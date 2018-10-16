namespace Ajmd\Config\Adapter;

use Ajmd\Config;
use Ajmd\Config\Exception;

class Ini extends Config
{
	public function __construct(string! filePath, mode = null)
	{
		var iniConfig;

		if null === mode {
			let mode = INI_SCANNER_RAW;
		}

		let iniConfig = parse_ini_file(filePath,true,mode);

		if iniConfig === false {
			throw new Exception("Configuration file ". basename(filePath) . " can't be loaded");
		}

		var config ,section, sections, directives, path, lastValue;

		let config = [];

		for section, directives in iniConfig {
			if typeof directives === "array" {
				let sections = [];
				for path, lastValue in directives {
					let sections[] = this->_parseIniString(strval(path),lastValue);
				}
				if count(sections) {
					let config[section] = call_user_func_array("array_merge_recursive",sections);
				}
			} else {
				let config[section] = this->_cast(directives);
			}
		}

		parent::__construct(config);
	}

	protected function _parseIniString(string! path, var value) -> array
	{
		var pos,key;
		let value = this->_cast(value);
		let pos = strpos(path,".");

		if pos === false {
			return [path:value];
		}

		let key = substr(path,0,pos);
		let path = substr(path, pos + 1);

		return [
			key:this->_parseIniString(path,value)
		];
	}

	protected function _cast(var ini) -> bool|null|double|int|string
	{
		var key ,value;
		if typeof ini === "array" {
			for key, value in ini {
				let ini[key] = this->_cast(value);
			}
		}

		if typeof ini === "string" {
			if in_array(ini,["true","yes","on"]) {
				return true;
			}

			if in_array(ini, ["false","no","off"]) {
				return false;
			}

			if ini === "null" {
				return null;
			}

			if is_numeric(ini) {
				if preg_match("/[.]+/",ini) {
					return (double)ini;
				} else {
					return (int) ini;
				}
			}
		}
		return ini;
	}
}



