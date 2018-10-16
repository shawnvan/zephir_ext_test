namespace Ajmd\Config;

use Ajmd\Config;
use Ajmd\Config\Adapter\Ini;
use Ajmd\Config\Adapter\Json;
use Ajmd\Config\Adapter\Php;
use Ajmd\Config\Adapter\Yaml;
use Ajmd\Config\Adapter\Xml;
use Ajmd\Config\Exception;

class Loader
{
    public function __construct()
    {

    }

    public function load(string! filePath)
    {
        var extension;
        if !is_file(filePath) {
            throw new Exception("file not found");
        }

        let extension = strtolower(pathinfo(filePath,PATHINFO_EXTENSION));

        switch extension {
            case "ini":
                return new Ini(filePath);
            case "json":
                return new Json(filePath);
            case "php":
            case "php5":
                return new Php(filePath);
            case "yml":
            case "yaml":
                return new Yaml(filePath);
            case "xml":
                return new Xml(filePath);
            default:
                throw new Exception("Config adatper for ". extension . " file not supported yet");
        }

    }
}