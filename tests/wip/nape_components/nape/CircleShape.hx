package tests.wip.nape_components.nape;


import luxe.Component;
import luxe.Vector;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.space.Space;


typedef PhysicsCircleShapeOptions = 
{
	@:optional var name : String;
	
	@:optional var radius : Float;
	
	@:optional var offset : Vector;
	
	@:optional var rotation : Float;
}

/**
 * ...
 * @author Kristian Brodal
 */
class CircleShape extends Component
{
	var body : Body;
	var shape : Circle;

	var options : PhysicsCircleShapeOptions;
	
	public function new(?_options : PhysicsCircleShapeOptions) {
		super( { name : (_options.name == null) ? "CircleShape" : _options.name } );
		
		if (_options == null) {
			this.options = {
				name : "CircleShape",
				radius : 10,
				offset : new Vector(0, 0),
				rotation : 0
			}
		} else {
			this.options = _options;
			this.options.name = (this.options.name == null) ? "CircleShape" : this.options.name;
			this.options.radius = (this.options.radius == null) ? 10 : this.options.radius;
			this.options.offset = (this.options.offset == null) ? new Vector(0, 0) : this.options.offset;
			this.options.rotation = (this.options.rotation == null) ? 0 : this.options.rotation;
		}
	}
	
	public override function init() {
		var rigidbody : RigidBody = cast this.entity.get("RigidBody");
		
			//	Make sure a rigidbody is attached to the same entity. otherwise the shape can not attach itself to the nape body of the rigidbody.
		if (rigidbody == null) throw "CircleShape requires a RigidBody to be attached to the entity";
		
		this.shape = new Circle(this.options.radius);
		this.shape.rotate(this.options.rotation);
		var offset = new Vec2(this.options.offset.x, this.options.offset.y);
		this.shape.translate(offset);
		offset.dispose();
		
		rigidbody.body.shapes.add(this.shape);
	}
	
	public override function onreset() {
		
	}
	
}