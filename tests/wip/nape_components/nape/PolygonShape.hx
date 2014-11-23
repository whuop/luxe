package tests.wip.nape_components.nape;

import luxe.Component;
import luxe.options.ComponentOptions;
import luxe.utils.JSON;
import luxe.Vector;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.shape.Polygon;
import sys.db.Object;

typedef PhysicsPolygonShapeOptions = 
{
	@:optional var name : String;
	
	@:optional var offset : Vector;
	
	@:optional var rotation : Float;
}

class PolygonShape extends Component
{
	var body : Body;
	var shape : Polygon;

	var options : PhysicsPolygonShapeOptions;
	
	public function new(?_options : PhysicsPolygonShapeOptions) {
		super( { name : (_options.name == null) ? "PolygonShape" : _options.name } );
		
		if (_options == null) {
			this.options = {
				name : "PolygonShape",
				offset : new Vector(0, 0),
				rotation : 0
			}
		} else {
			this.options = _options;
			this.options.name = (this.options.name == null) ? "PolygonShape" : this.options.name;
			this.options.offset = (this.options.offset == null) ? new Vector(0, 0) : this.options.offset;
			this.options.rotation = (this.options.rotation == null) ? 0 : this.options.rotation;
		}
	}
	
	public override function init() {
		
		
		
	}
	
	public function from_json( _polygonData : Dynamic) {
		if (_polygonData == null) throw "Null polygon data passed to from_json in PolygonShape";
		
		var polygonObject : Dynamic = JSON.parse(_polygonData);
		trace(polygonObject);
		
		var verts = new Array<Vector>();
		var vertsData : Array<Dynamic> = cast polygonObject.vertices;
		
		for ( vert in vertsData ) {
			verts.push(new Vector(vert.x, vert.y));
		}
		
		from_array(verts);
	}
	
	public function from_array( _verts : Array<Vector>) {
		var rigidbody : RigidBody = cast this.entity.get("RigidBody");
		
			//	Make sure a rigidbody is attached to the same entity.
		if (rigidbody == null) throw "PolygonShape requires a RigidBody to be attached to the entity";
		
		this.shape = new Polygon(vector_array_to_vec2_array(_verts));
		var offset = new Vec2(this.options.offset.x, this.options.offset.y);
		this.shape.translate(offset);
		this.shape.rotate(this.options.rotation);
		offset.dispose();
		
		rigidbody.body.shapes.add(this.shape);
	}
	
	public override function onreset() {
		
	}
	
	private function vector_array_to_vec2_array(vertices : Array<Vector>) {
		var vec2Verts = new Array<Vec2>();
		for (vert in vertices) {
			vec2Verts.push(Vec2.weak(vert.x, vert.y));
		}
		return vec2Verts;
	}
}