package luxe.components.physics.nape;

import luxe.Component;
import luxe.options.ComponentOptions;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.space.Space;

typedef PhysicsBodyOptions = 
{
	@:optional var name : String;
	@:optional var body_type : BodyType;
	@:optional var space : Space;
}

class RigidBody extends Component
{
	
	var options : PhysicsBodyOptions;
	
		//	Nape body for this rigidbody.
	@:isVar
	public var body(default, null) : Body;
	
	public function new(?_options:PhysicsBodyOptions) 
	{
		super( { name : (_options.name == null) ? "RigidBody" : _options.name } );
		
		if (_options == null) {
			this.options = {
				name : "RigidBody",
				body_type : BodyType.DYNAMIC,
				space : Luxe.physics.nape.space
			}
		} else {
			this.options = _options;
			
			this.options.body_type = (this.options.body_type == null) ? BodyType.DYNAMIC : this.options.body_type;
			this.options.space = (this.options.space == null) ? Luxe.physics.nape.space : this.options.space;
		}
		
		this.body = new Body(this.options.body_type);
		
	}
	
	override function init() {
		
	} // init
	
	override function onreset() {
		var pos = new Vec2(this.entity.transform.pos.x, this.entity.transform.pos.y);
		
		this.body.position = pos;
		this.body.space = this.options.space;
		
			//	Be sure to clean up.
		pos.dispose();
	}
	
	override function update( dt: Float ) {
		if (this.options.body_type == BodyType.STATIC) {
			return;
		}
		
		this.transform.pos.x = this.body.position.x;
		this.transform.pos.y = this.body.position.y;
	}
	
	public function destroyed() {
		
	} // destroyed
	
}