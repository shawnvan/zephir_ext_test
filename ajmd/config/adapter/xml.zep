namespace Ajmd\Config\Adapter;

use Ajmd\Config;
use Ajmd\Config\Exception;

class Xml extends Config
{
    public function __construct(string! filePath)
    {
        var xmlConfig, loadError, e;
        if ! extension_loaded("SimpleXML") {
            throw new Exception("simpleXml extension not loaded");
        }
        libxml_use_internal_errors(true);

        let xmlConfig = simplexml_load_file(filePath,"SimpleXMLElement",LIBXML_NOCDATA);

        for e in loadError {
            switch e->code {
                case LIBXML_ERR_WARNING:
                    // code
                    trigger_error(e->message,E_USER_WARNING);
                    break;
                default :
                    throw new Exception(e->message);
            }
        }
        libxml_use_internal_errors(false);

        parent::__construct(json_encode(xmlConfig));
            
    }
}