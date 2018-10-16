namespace Ajmd\Logger;

use Ajmd\Factory as BaseFactory;
use Ajmd\Factory\Exception;
use Ajmd\Config;

class Factory extends BaseFactory
{
    /**
	 * @param \Ajmd\Config|array config
	 */
	public static function load(var config) 
	{
		return self::loadClass("Ajmd\\Logger\\Adapter", config);
	}

	protected static function loadClass(string $namespace, var config)
	{
		var adapter, className, name;

		if typeof config == "object" && config instanceof Config {
			let config = config->toArray();
		}

		if typeof config != "array" {
			throw new Exception("Config must be array or Ajmd\\Config object");
		}

		if fetch adapter, config["adapter"] {
			let className = $namespace."\\".camelize(adapter);

			if className != "Ajmd\\Logger\\Adapter\\Firephp" {
				unset config["adapter"];
				if !fetch name, config["name"] {
					throw new Exception("You must provide 'name' option in factory config parameter.");
				}
				unset config["name"];

				return new {className}(name, config);
			}

			return new {className}();
		}

		throw new Exception("You must provide 'adapter' option in factory config parameter.");
	}
}