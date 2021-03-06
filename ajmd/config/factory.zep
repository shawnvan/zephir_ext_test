
/*
 +------------------------------------------------------------------------+
 | Ajmd Framework                                                      |
 +------------------------------------------------------------------------+
 | Copyright (c) 2011-2017 Ajmd Team (https://Ajmdphp.com)          |
 +------------------------------------------------------------------------+
 | This source file is subject to the New BSD License that is bundled     |
 | with this package in the file LICENSE.txt.                             |
 |                                                                        |
 | If you did not receive a copy of the license and are unable to         |
 | obtain it through the world-wide-web, please send an email             |
 | to license@Ajmdphp.com so we can send you a copy immediately.       |
 +------------------------------------------------------------------------+
 | Authors: Andres Gutierrez <andres@Ajmdphp.com>                      |
 |          Eduar Carvajal <eduar@Ajmdphp.com>                         |
 |          Wojciech Ślawski <jurigag@gmail.com>                          |
 +------------------------------------------------------------------------+
 */

namespace Ajmd\Config;

use Ajmd\Factory as BaseFactory;
use Ajmd\Factory\Exception;
use Ajmd\Config;

/**
 * Loads Config Adapter class using 'adapter' option, if no extension is provided it will be added to filePath
 *
 *<code>
 * use Ajmd\Config\Factory;
 *
 * $options = [
 *     "filePath" => "path/config",
 *     "adapter"  => "php",
 * ];
 * $config = Factory::load($options);
 *</code>
 */
class Factory extends BaseFactory
{
	/**
	 * @param \Ajmd\Config|array config
	 */
	public static function load(var config) -> object
	{
		return self::loadClass("Ajmd\\Config\\Adapter", config);
	}

	protected static function loadClass(string $namespace, var config)
	{
		var adapter, className, mode, callbacks, filePath, extension, oldConfig;

		if typeof config == "string" {
			let oldConfig = config;
			let extension = substr(strrchr(config, "."), 1);

			if empty extension {
				throw new Exception("You need to provide extension in file path");
			}

			let config = [
				"adapter": extension,
				"filePath": oldConfig
			];
		}

		if typeof config == "object" && config instanceof Config {
			let config = config->toArray();
		}

		if typeof config != "array" {
			throw new Exception("Config must be array or Ajmd\\Config object");
		}

		if !fetch filePath, config["filePath"] {
			throw new Exception("You must provide 'filePath' option in factory config parameter.");
		}

		if fetch adapter, config["adapter"] {
			let className = $namespace."\\".camelize(adapter);
			if !strpos(filePath, ".") {
				let filePath = filePath.".".lcfirst(adapter);
			}

			if className == "Ajmd\\Config\\Adapter\\Ini" {
				if fetch mode, config["mode"] {
					return new {className}(filePath, mode);
				}
			} elseif className == "Ajmd\\Config\\Adapter\\Yaml" {
				if fetch callbacks, config["callbacks"] {
					return new {className}(filePath, callbacks);
				}
			}

			return new {className}(filePath);
		}

		throw new Exception("You must provide 'adapter' option in factory config parameter.");
	}
}
