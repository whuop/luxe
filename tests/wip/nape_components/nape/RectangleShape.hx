package tests.wip.nape_components.nape;

import luxe.Component;
import luxe.options.ComponentOptions;
import luxe.Vector;
import nape.shape.Polygon;
import nape.phys.Body;

typedef PhysicsRectangleShapeOptions = 
{
	@:optional var name : String;
	
	@:optional var size : Vector;
	
	@:optional var offset : Vector;
}

class RectangleShape extends Component
{
	var body : Body;
	var shape : Polygon;

	var options : PhysicsRectangleShapeOptions;
	
	public function new(?_options : PhysicsRectangleShapeOptions) {
		super( { name : (_options.name == null) ? "CircleShape" : _options.name } );
		
		if (_options == null) {
			this.options = {
				name : "RectangleSha",
				size : new Vector(10,10),
				offset : new Vector(0,0)
			}
		} else {
			this.options = _options;
			this.options.name = (this.options.name == null) ? "CircleShape" : this.options.name;
			this.options.size = (this.options.size == null) ? new Vector(10,10) : this.options.size;
			this.options.offset = (this.options.offset == null) ? new Vector(0, 0) : this.options.offset;
		}
	}
	
	public override function init() {
		var rigidbody : RigidBody = cast this.entity.get("RigidBody");
		
			//	Make sure a rigidbody is attached to the same entity.
		if (rigidbody == null) {
			trace("CircleShape must have a RigidBody attached to the same entity!");
			return;
		}
		
		this.shape = new Polygon(Polygon.box(this.options.size.x, this.options.size.y));
		var offset = new Vec2(this.options.offset.x, this.options.offset.y);
		this.shape.translate(offset);
		offset.dispose();
		
		rigidbody.body.shapes.add(this.shape);
	}
	
	public override function onreset() {
		
	}
	
}