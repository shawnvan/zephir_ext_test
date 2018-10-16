namespace Ajmd\Config\Adapter;

use Ajmd\Config;
use Ajmd\Config\Exception;
use Ajmd\Config\Factory;

class Grouped extends Config
{
	public function __construct(array! arrayConfig, string! defaultAdapter = "php")
	{
		var configName,configInstance,configArray;
		parent::__construct([]);

		for configName in arrayConfig {
			let configInstance = configName;

			if typeof configName === "string" {
				let configInstance = [
					"filePath" : configName
				];
			}

			if !isset configInstance["adapter"] {
				let configInstance["adapter"] = defaultAdapter;
			}

			if configInstance["adapter"] === "array" {
				if !isset configInstance["config"] {
					throw new Exception("To use 'array' adapter you must specify the 'config' as an array.");
				}
				let configArray =  configInstance["config"];
				let configInstance = new Config(configArray);
			} else {
				let configInstance = Factory::load(configInstance);
			}
			this->_merge(configInstance);
		}

	}
}