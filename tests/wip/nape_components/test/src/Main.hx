package;


import luxe.Entity;
import luxe.Input;
import luxe.Vector;
import tests.wip.nape_components.nape.RigidBody;
import nape.phys.BodyType;
import tests.wip.nape_components.nape.CircleShape;
import tests.wip.nape_components.nape.RectangleShape;
import tests.wip.nape_components.nape.PolygonShape;


class Main extends luxe.Game 
{
	
	override function ready() 
	{
		Luxe.physics.nape.draw = true;
		
			//	Initialize the player controlled unit.
		var playerBall = new Entity( {
			name : "Cylinder",
			pos : new Vector(Luxe.screen.w / 2, Luxe.screen.h / 2)
		});
		
		playerBall.add(new RigidBody( {
			name : "RigidBody",
			body_type : BodyType.DYNAMIC
		} ) );
		
		playerBall.add(new CircleShape( {
			name : "CylinderBallCircleShape",
			radius : 50,
			offset : new Vector(100, 0),
			rotation : 0.25
		} ) );
		
		playerBall.add(new CircleShape( {
			name : "CylinderBallCircleShape2",
			radius : 50
		} ) );
		
		playerBall.add(new RectangleShape( {
			name : "CylinderBallRectangle",
			size : new Vector(100, 100),
			offset : new Vector(50, 0)
		} ) );
		
		
		var floor = new Entity( {
			name : "Floor",
			pos : new Vector(Luxe.screen.w / 2, Luxe.screen.h - 100)
		} );
		
		floor.add(new RigidBody( {
			name : "RigidBody",
			body_type : BodyType.STATIC
		} ));
		
		floor.add(new RectangleShape( {
			name : "FloorRectangle",
			size : new Vector(Luxe.screen.w, 50)
		} ) );
		
		var box = new Entity( {
			name : "Box",
			pos : new Vector((Luxe.screen.w / 2) - 150, Luxe.screen.h / 2)
		} );
		
		box.add(new RigidBody( {
			name : "RigidBody",
			body_type : BodyType.DYNAMIC
		} ) );
		
		var polygonShape = box.add(new PolygonShape( {
			name : "FloorRectangle2"
		} ));
		
		var verts = new Array<Vector>();
		verts.push(new Vector(0, 0));
		verts.push(new Vector(100, 0));
		verts.push(new Vector(100, 100));
		verts.push(new Vector(0, 100));
		
		polygonShape.from_array(verts);
		
		box = new Entity( {
			name : "Box2",
			pos : new Vector((Luxe.screen.w / 2) - 255, Luxe.screen.h / 2)
		} );
		
		box.add(new RigidBody( {
			name : "RigidBody",
			body_type : BodyType.DYNAMIC
		} ) );
		
		polygonShape = box.add(new PolygonShape( {
			name : "FloorRectangle2"
		} ));
		
		var polygon_json = '
				{
					"vertices" : [ { "x" : 0, "y" : 0 },
								{ "x" : 100, "y" : 0 },
								{ "x" : 100, "y" : 100 },
								{ "x" : 0, "y" : 100 }]
				}
			';
			
		polygonShape = box.add(new PolygonShape( {
			name : "FloorRectangle2",
			offset : new Vector(-30, 0),
			rotation : 0
		} ));
			
		polygonShape.from_json(polygon_json);
	}
	

	override function onkeyup(e:KeyEvent) 
	{
		if(e.keycode == Key.escape)
			Luxe.shutdown();
	}

	override function update(dt:Float) 
	{
		
	}
}
