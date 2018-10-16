namespace Ajmd\Config\Adapter;

use Ajmd\Config;
use Ajmd\Config\Exception;

/**
 * 		
 */
class Yaml extends Config
{
	
	public function __construct(string! filePath, array! callbacks = null)
	{
		var yamlConfig;
		int ndocs = 0;

		if !extension_loaded("yaml") {
			throw new Exception("yaml extension needed");
		}

		if callbacks !== null {
			let yamlConfig = yaml_parse_file(filePath,0,ndocs,callbacks);
		} else {
			let yamlConfig = yaml_parse_file(filePath);
		}

		if yamlConfig === false {
			throw new Exception("Configuration file " . basename(filePath) . " can't be loaded");
		}

		parent::__construct(yamlConfig);
	}
}