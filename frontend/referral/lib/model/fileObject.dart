import 'dart:io';

class FileObject{
	File _file;
	String _fileName;

	get file =>_file;
	set file(value) => _file=value;

	get fileName =>_fileName;
	set fileName(value) => _fileName=value;

	FileObject({
		File file,
		String fileName = '',
	}) : 	_file = file,
				_fileName = fileName;
	
}
