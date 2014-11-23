package luxe.components.physics.nape;

import luxe.Component;
import luxe.components.physics.nape.CircleShape.PhsyicsCircleShapeOptions;
import luxe.Vector;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.space.Space;

typedef PhsyicsCircleShapeOptions = 
{
	@:optional var name : String;
	
	@:optional var radius : Float;
	
	@:optional var offset : Vector;
}

/**
 * ...
 * @author Kristian Brodal
 */
class CircleShape extends Component
{
		//	Body that this CircleShape is attached to
	var body : Body;
	var shape : Circle;

	var options : PhsyicsCircleShapeOptions;
	
	public function new(?_options : PhsyicsCircleShapeOptions) {
		super( { name : (_options.name == null) ? "CircleShape" : _options.name } );
		
		if (_options == null) {
			this.options = {
				name : "CircleShape",
				radius : 10,
				offset : new Vector(0,0)
			}
		} else {
			this.options = _options;
			this.options.name = (this.options.name == null) ? "CircleShape" : this.options.name;
			this.options.radius = (this.options.radius == null) ? 10 : this.options.radius;
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
		
		this.shape = new Circle(this.options.radius);
		var offset = new Vec2(this.options.offset.x, this.options.offset.y);
		this.shape.translate(offset);
		offset.dispose();
		
		rigidbody.body.shapes.add(this.shape);
	}
	
	public override function onreset() {
		
	}
	
}