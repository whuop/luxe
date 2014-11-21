package luxe.physics.nape.shapes;

import luxe.Component;
import luxe.options.ComponentOptions;
import Luxe.Vector;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.space.Space;

typedef CircleOptions = 
{
	@:optional var name : String;
	
	@:optional var body : Body;
	
	@:optional var bodyType : BodyType;
	
	@:optional var pos : Vector;
	
	@:optional var radius : Float;
	
	@:optional var space : Space;
}

/**
 * ...
 * @author Kristian Brodal
 */
class CircleShape extends Component
{
	
	var body : Body;
	
	var bodyType : BodyType;
	
	public function new(?_options : CircleOptions) {
		super({name : _options.name});
		
		var pos : Vec2;
		if (_options.pos != null) {
			pos = new Vec2(0, 0);
		}
		else {
			pos = new Vec2(_options.pos.x, _options.pos.y);
		}
		
			//	If a body type is specified, use that one, otherwise create the body as a dynamic body
		this.bodyType = (_options.bodyType == null) ? BodyType.DYNAMIC : _options.bodyType;
			//	If a body is supplied, use that one, otherwise create a new one.
		this.body = (_options.body == null) ? new Body(this.bodyType, pos) : _options.body;
		
		var radius = (_options.radius == null) ? 1 : _options.radius;
		
		//this.body.shapes
	}
	
	public override function update( dt : Float ){
		this.transform.pos.x = this.body.position.x;
		this.transform.pos.y = this.body.position.y;
	}
	
	public override function onreset( ) {
		
	}
	
}