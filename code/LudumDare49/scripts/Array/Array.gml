// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Array(_array) constructor{
	array = [];
	if(_array!=undefined) array = _array;
	
	function toString() { return string(array); }
	function get(_index) { 
		if(_index>=0&&_index<size()) return array[_index]; 
		else return noone;
	}
	function at(_index) { return get(_index); }
	function clear() { array = []; }
	function empty() { return array_length(array)==0; }
	function size() { return array_length(array); }
	function length() { return array_length(array); }
	function push(_element) { array_push(array,_element); }
	function pop() { if(!empty()) array_delete(array,0,1); }
	function top() { 
		if(!empty()) return array[0]; 
		else return noone;
	}
	function find(_element) {
		for(var i=0;i<size();i++) {
			if(array[i]==_element) return i;
		}
		return -1;
	}
	function erase(_element) {
		for(var i=0;i<size();++i){
			if(array[i]==_element) {array_delete(array,i,1);break;}
		}
	}
	function copy() {
		var tmp = new Array();
		array_copy(tmp.array,0,array,0,array_length(array));
		return tmp;
	}
	function shuffle() {
		for(var i=size();i>1;i--) {
			var rnd = irandom(i-1);
			var tmp = array[i-1];
			array[i-1] = array[rnd];
			array[rnd] = tmp;
		}
	}
	function iterator(func){
		var len = size();
		for(var i=0;i<len;++i){
			func(i,len,array);
		}
	}
}