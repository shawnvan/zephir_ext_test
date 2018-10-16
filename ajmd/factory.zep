namespace Ajmd;

use Ajmd\Factory\Exception;
use Ajmd\Config;

abstract class Factory implements FactoryInterface
{
	protected static function loadClass(string $namespace, var config)
	{
		var adapter, className;

		if typeof config === "object" && config instanceof Config {
			let config = config->toArray();
		}

		if typeof config != "array" {
			throw new Exception("Config must be array or Ajmd\\Config object");
		}

		if fetch adapter,config["adapter"] {
			unset config["adapter"];
			let className = $namespace."\\".adapter;

			return new {className}(config);
		}

		throw new Exception("You must provide 'adapter' option in factory config parameter.", 1);
		
	}
}