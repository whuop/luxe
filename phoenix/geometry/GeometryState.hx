package phoenix.geometry;

import phoenix.Texture;
import phoenix.Batcher;

class GeometryState {
    
    public var dirty:Bool;

    public var depth:Float;
    public var group:Int;
    public var texture:Texture;
    public var primitive_type:PrimitiveType;
    public var clip:Bool;   


    public function new() {
        
        dirty = false;

        clip = false;
        texture = null;
        group = 0;
        depth = 0.0;
        primitive_type = PrimitiveType.none;

    }

    public function str() {
        trace('\t+ GEOMETRYSTATE');
            trace("\t\tdepth - "+ depth);
            trace("\t\tgroup - "+ group);
            trace("\t\ttexture - " + (( texture == null) ? 'null' :  texture.id ));
            if(texture != null) {
                trace("\t\t\t " + texture.texture);
            }            
            trace("\t\tprimitive_type - "+ primitive_type);
            trace("\t\tclip - "+ clip);
        trace('\t- GEOMETRYSTATE');     
    }    

    public function clean() {
        dirty = false;
    }

    public function compare( other:GeometryState ) {
        
        if( depth < other.depth ) return -1;

        if( depth == other.depth && group < other.group ) return -1;

        var textureid : Dynamic = texture != null ? texture.id : 0;
        var other_textureid : Dynamic = other.texture != null ? other.texture.id : 0;

        trace("TID " + textureid);
        trace("OTHER TID " + other_textureid);

        var clip_value : Int;
        if(clip == true && other.clip == true) clip_value = 0;
        if(clip == false && other.clip == true) clip_value = -1;
        if(clip == true && other.clip == false) clip_value = 1;

        if( depth == other.depth && group == other.group && textureid < other_textureid ) return -1;
        
        // todo
        // if( depth == other.depth && group == other.group && textureid == other_textureid && primitive_type < other.primitive_type) return -1;
        // if( depth == other.depth && group == other.group && textureid == other_textureid && primitive_type == other.primitive_type && (clip_value >= 0)) return -1;

        return 1;
    }

    public function update( other : GeometryState ) {
        depth = other.depth;
        group = other.group;
        texture = other.texture;
        primitive_type = other.primitive_type;
        clip = other.clip;        
    }

}
