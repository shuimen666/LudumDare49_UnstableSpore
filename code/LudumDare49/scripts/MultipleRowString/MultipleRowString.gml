// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MultipleRowString(wstring,rowW) {
	var NextLineChar = "\n";
	var NewLineString = "";

	var RestrainLw = rowW - 6;
	var charCnt = string_length(wstring);
	var CurLineLen = 0;
	for(var i=1;i<=charCnt;i++)
	{
		var tmplen = CurLineLen;
		var char = string_char_at(wstring,i);
		var char_size = string_width(char);
		tmplen += char_size;
		if(tmplen <=RestrainLw && char!=NextLineChar){
			NewLineString += char;
			CurLineLen = tmplen;
		}else{
			if(NewLineString!=""){NewLineString += NextLineChar;}
			if(char==NextLineChar){
				CurLineLen = 0;
			}else{
				NewLineString += char;
				CurLineLen = char_size;
			}
		}
	}
	return NewLineString;
}