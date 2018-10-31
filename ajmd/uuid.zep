namespace Ajmd;

use Ajmd\Exception;

class Uuid
{
    public static function generateId() -> string
    {
        if ! extension_loaded("mongodb") {
            return self::__generateByRandom();
        }
        return (string) new \MongoDB\BSON\ObjectId();
    }

    private static function __generateByRandom() -> string
    {
       var randStr ,uuid;
        let randStr = md5(uniqid(mt_rand()), false);
        let uuid = substr(randStr,0,8)."-";
        let uuid .= substr(randStr,8,4)."-";
        let uuid .= substr(randStr,12,4)."-";
        let uuid .= substr(randStr,16,4)."-";
        let uuid .= substr(randStr,20,12);
        return uuid;
    }
}