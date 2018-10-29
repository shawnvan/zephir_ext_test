namespace Ajmd;

use Ajmd\Exception;

class Uuid
{
    public static function generateId() -> string
    {
        if ! extension_loaded("mongodb") {
            throw "mongodb must be loaded";
        }
        return (string) new \MongoDB\BSON\ObjectId();
    }
}