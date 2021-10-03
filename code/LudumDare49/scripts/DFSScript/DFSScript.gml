// Script assets have changed for v2.3.false see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __DFSAddSome(_queue,_row,_col,_num,_parent) {
	var tmp = false;
	for(var i=0;i<array_length(_queue);i++) {
		if(_queue[i][$ "row"]==_row&&_queue[i][$ "col"]==_col) {
			tmp = true;
			if(_queue[i][$ "num"]<=_num) {
				_queue[i][$ "num"] = _num;
				_queue[i][$ "parent"] = _parent;
				return;
			}
		}
	}
	if(!tmp) array_push(_queue,{
		row: _row,
		col: _col,
		num: _num,
		parent: _parent
	});
}
function __DFSAddQueue(_queue,_close,_row,_col,_num,_parent) {
	for(var i=0;i<array_length(_close);i++) {
		if(_close[i][$ "row"]==_row&&_close[i][$ "col"]==_col) {
			if(_close[i][$ "num"]>=_num) {
				return;
			}
			else {
				_close[i][$ "num"] = _num;
				_close[i][$ "parent"] = _parent;
			}
		}
	}
	__DFSAddSome(_queue,_row,_col,_num,_parent);
}
function DFSFindAble(_boot,_map,_row,_col) {
	var flag = false;
	var queue = [], close = [];
	if(_boot==-1) { 
		_boot = 10; 
		for(var i=0;i<7;i++)
			for(var j=0;j<7;j++)
				if(CellExist(i,j)&&_map[i,j]==0) __DFSAddQueue(queue,close,i,j,_boot-1,[_row,_col]);
	}
	else {
		if(CellExist(_row-1,_col)&&_map[_row-1,_col]==0) __DFSAddQueue(queue,close,_row-1,_col,_boot-1,[_row,_col]);
		if(CellExist(_row+1,_col)&&_map[_row+1,_col]==0) __DFSAddQueue(queue,close,_row+1,_col,_boot-1,[_row,_col]);
		if(CellExist(_row,_col-1)&&_map[_row,_col-1]==0) __DFSAddQueue(queue,close,_row,_col-1,_boot-1,[_row,_col]);
		if(CellExist(_row,_col+1)&&_map[_row,_col+1]==0) __DFSAddQueue(queue,close,_row,_col+1,_boot-1,[_row,_col]);
	}
	while(array_length(queue)>0)
	{
		var now = queue[0];
		var nrow = now[$ "row"], ncol = now[$ "col"], nnum = now[$ "num"];
		if(nnum>0) {
			if(CellExist(nrow-1,ncol)&&_map[nrow-1,ncol]==0) __DFSAddQueue(queue,close,nrow-1,ncol,nnum-1,[nrow,ncol]);
			if(CellExist(nrow+1,ncol)&&_map[nrow+1,ncol]==0) __DFSAddQueue(queue,close,nrow+1,ncol,nnum-1,[nrow,ncol]);
			if(CellExist(nrow,ncol-1)&&_map[nrow,ncol-1]==0) __DFSAddQueue(queue,close,nrow,ncol-1,nnum-1,[nrow,ncol]);
			if(CellExist(nrow,ncol+1)&&_map[nrow,ncol+1]==0) __DFSAddQueue(queue,close,nrow,ncol+1,nnum-1,[nrow,ncol]);
		}
		__DFSAddSome(close,nrow,ncol,nnum,now[$ "parent"]);
		array_delete(queue,0,1);
	}
	return close;
}
function DFSClose2Map(_close)
{
	var result = [
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0]
	];
	for(var i=0;i<array_length(_close);i++)
	{
		result[_close[i][$ "row"]][_close[i][$ "col"]] = 1;
	}
	return result;
}
function __inRange(_row,_col) {
	 return (_row>=0&&_row<7&&_col>=0&&_col<7);
}
function __inClose(close,array2) {
	for(var i=0;i<array_length(close);i++) {
		if(close[i][0]==array2[0]&&close[i][1]==array2[1]) return true;
	}
	return false;
}
function DFSCreateCells(_row,_col)
{
	var result = [
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0]
	];
	var queue = [], close = [];
	array_push(queue,[_row,_col]);
	array_push(queue,[_row-1,_col]);
	array_push(queue,[_row+1,_col]);
	array_push(queue,[_row,_col-1]);
	array_push(queue,[_row,_col+1]);
	show_debug_message(queue[0]);
	while(array_length(queue)>0) {
		var now = queue[0];
		var pool = [];
		if(__inRange(now[0]-1,now[1])&&!__inClose(close,[now[0]-1,now[1]])) array_push(pool,[now[0]-1,now[1]]);
		if(__inRange(now[0]+1,now[1])&&!__inClose(close,[now[0]+1,now[1]])) array_push(pool,[now[0]+1,now[1]]);
		if(__inRange(now[0],now[1]-1)&&!__inClose(close,[now[0],now[1]-1])) array_push(pool,[now[0],now[1]-1]);
		if(__inRange(now[0],now[1]+1)&&!__inClose(close,[now[0],now[1]+1])) array_push(pool,[now[0],now[1]+1]);
		var n = irandom(3); if(n>array_length(pool)) n = array_length(pool);
		for(var i=0;i<n;i++) {
			var rn = irandom(array_length(pool)-1);
			if(!__inClose(queue,pool[rn])) array_push(queue,pool[rn]);
			array_delete(pool,rn,1);
		}
		result[now[0],now[1]] = 1;
		array_push(close,now);
		array_delete(queue,0,1);
	}
	return result;
}