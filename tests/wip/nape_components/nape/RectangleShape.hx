package tests.wip.nape_components.nape;


import luxe.Component;
import luxe.options.ComponentOptions;
import luxe.Vector;
import nape.geom.Vec2;
import nape.shape.Polygon;
import nape.phys.Body;


typedef PhysicsRectangleShapeOptions = 
{
	@:optional var name : String;
	
	@:optional var size : Vector;
	
	@:optional var offset : Vector;
	
	@:optional var rotation : Float;
}

class RectangleShape extends Component
{
	var body : Body;
	var shape : Polygon;

	var options : PhysicsRectangleShapeOptions;
	
	public function new(?_options : PhysicsRectangleShapeOptions) {
		super( { name : (_options.name == null) ? "RectangleShape" : _options.name } );
		
		if (_options == null) {
			this.options = {
				name : "RectangleShape",
				size : new Vector(10,10),
				offset : new Vector(0, 0),
				rotation : 0
			}
		} else {
			this.options = _options;
			this.options.name = (this.options.name == null) ? "RectangleShape" : this.options.name;
			this.options.size = (this.options.size == null) ? new Vector(10,10) : this.options.size;
			this.options.offset = (this.options.offset == null) ? new Vector(0, 0) : this.options.offset;
			this.options.rotation = (this.options.rotation == null) ? 0 : this.options.rotation;
		}
	}
	
	public override function init() {
		var rigidbody : RigidBody = cast this.entity.get("RigidBody");
		
			//	Make sure a rigidbody is attached to the same entity. otherwise the shape can not attach itself to the nape body of the rigidbody.
		if (rigidbody == null)"RectangleShape requires a RigidBody to be attached to the entity";
		
		this.shape = new Polygon(Polygon.box(this.options.size.x, this.options.size.y));
		var offset = new Vec2(this.options.offset.x, this.options.offset.y);
		this.shape.translate(offset);
		this.shape.rotate(this.options.rotation);
		offset.dispose();
		
		rigidbody.body.shapes.add(this.shape);
	}
	
	public override function onreset() {
		
	}
	
}