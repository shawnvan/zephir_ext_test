namespace Ajmd;

use Ajmd\Config\Exception;

class Config implements \ArrayAccess, \Countable
{
	protected static _delimiter;

	const DEFAULT_PATH_DELEMITER = ".";

	public function __construct(array! arrayConfig = null)
	{
		var key, value;
		for key, value in arrayConfig {
			this->offsetSet(key,value);
		}
	}

	public function offsetExists(var index) ->boolean
	{
		let index = strval(index);
		return isset this->{index};
	}


	public function path(string! path, var defaultValue = null, var delimiter = null) -> var
	{
		var key, keys, config;

		if isset this->{path} {
			return this->{path};
		}

		if empty delimiter {
			let delimiter = self::getPathDelimiter();
		}

		let config = this,
			keys = explode(delimiter,path);

		while !empty keys {
			let key = array_shift(keys);

			if !isset config->{key} {
				break;
			}

			if empty keys {
				return config->{key};
			}

			let config = config->{key};

			if empty config {
				break;
			}
		}

		return defaultValue;
	}

	public function get(var index,var defaultValue){
		let index = strval(index);

		if isset this->{index} {
			return this->{index};
		}

		return defaultValue;
	}

	public function offsetGet(var index) -> string
	{
		let index = strval(index);

		return this->{index};
	}

	public function offsetSet(var index, var value) -> void
	{
		let index = strval(index);

		if typeof value === "array" {
			let this->{index} = new self(value);
		} else {
			let this->{index} = value;
		}
	}

	public function offsetUnset(var index)
	{
		let index = strval(index);
		let this->{index} = null;
	}

	public function merge(<Config> config) -> <Config>
	{
		return this->_merge(config);
	}

	public function toArray() -> array
	{
		var key, value, arrayConfig;
		for key, value in get_object_vars(this) {
			if typeof value === "object" {
				if method_exists(value, "toArray") {
					let arrayConfig = value->toArray();
				} else {
					let arrayConfig[key] = value;
				}
			} else {
				let arrayConfig[key] = value;
			}
		}
		return arrayConfig;
	}

	public function count() -> int
	{
		return count(get_object_vars(this));
	}

	public static function __set_state(array! data) -> <Config>
	{
		return new self(data);
	}

	public static function setPathDelimiter(string! delimiter = null) -> void
	{
		let self::_delimiter = delimiter;
	}

	public static function getPathDelimiter() -> string
	{
		var delimiter;
		let delimiter = self::_delimiter;

		if !delimiter {
			let delimiter = self::DEFAULT_PATH_DELEMITER;
		}

		return delimiter;
	}

	protected final function _merge(<Config> config,var instance = null) -> <Config>
	{
		var key, value, number, localObject, property;

		if typeof instance !== "object" {
			let instance = this;
		}

		let number = instance->count();

		for key, value in get_object_vars(config) {
			let property = strval(key);
			if fetch localObject,instance->{property} {
				if typeof localObject === "object" && typeof value === "object" {
					if localObject instanceof Config && value instanceof Config{
						this->_merge(value, localObject);
						continue;
					}
				}
			}

			if is_numeric(key)
			{
				let key = strval(number);
				let number++;
			}
			let instance->{key} = value;
		}
		return instance;
	}
}


