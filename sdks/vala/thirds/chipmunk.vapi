/*
 *  This Source Code Form is subject to the terms of the Mozilla Public
 *  License, v. 2.0. If a copy of the MPL was not distributed with this
 *  file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 *                          Copyright(C) 2013
 *                   Christian Ferraz Lemos de Sousa
 *                      Pedro Henrique Lara Campos
 *
 */
//FOR: Chipmunk 6.1.4 - This is not official, to be futurely changed for the official binding
//Maintainer: PedroHLC

[CCode (cprefix = "cp", lower_case_cprefix = "cp")]
namespace cp {
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpArrayFree")]
	[Compact]
	public class Array {
		[CCode (cname = "cpArrayNew")]
		public Array (int size);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class BBTree : cp.SpatialIndex {
		[CCode (cname = "cpBBTreeNew")]
		public BBTree (cp.SpatialIndexBBFunc bbfunc, cp.SpatialIndex static_index);
		[CCode (cname = "cpBBTreeInit")]
		public unowned cp.BBTree init (cp.SpatialIndexBBFunc bbfunc, cp.SpatialIndex static_index);
		[CCode (cname = "cpBBTreeOptimize")]
		public void optimize ();
		[CCode (cname = "cpBBTreeSetVelocityFunc")]
		public void tree_set_velocity_func (cp.BBTreeVelocityFunc func);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpBodyFree")]
	[Compact]
	public class Body {
		public double a;
		public cp.Arbiter arbiter_list_private;
		public weak cp.Constraint constraint_list_private;
		public void* data;
		public cp.Vect f;
		public double i;
		public double i_inv;
		public double m;
		public double m_inv;
		public weak cp.ComponentNode node_private;
		public cp.Vect p;
		public weak cp.BodyPositionFunc position_func;
		public cp.Vect rot;
		public weak cp.Shape shape_list_private;
		public weak cp.Space space_private;
		public double t;
		public cp.Vect v;
		public cp.Vect v_bias_private;
		public double v_limit;
		public weak cp.BodyVelocityFunc velocity_func;
		public double w;
		public double w_bias_private;
		public double w_limit;
		
		[CCode (cname = "cpBodyNew")]
		public Body (double m, double i);
		[CCode (cname = "cpBodyActivate")]
		public void activate ();
		[CCode (cname = "cpBodyActivateStatic")]
		public void activate_static (cp.Shape filter);
		[CCode (cname = "cpBodyApplyForce")]
		public void apply_force (cp.Vect f, cp.Vect r);
		[CCode (cname = "cpBodyApplyImpulse")]
		public void apply_impulse (cp.Vect j, cp.Vect r);
		[CCode (cname = "cpBodyEachArbiter")]
		public void each_arbiter (cp.BodyArbiterIteratorFunc func, void* data);
		[CCode (cname = "cpBodyEachConstraint")]
		public void each_constraint (cp.BodyConstraintIteratorFunc func, void* data);
		[CCode (cname = "cpBodyEachShape")]
		public void each_shape (cp.BodyShapeIteratorFunc func, void* data);
		[CCode (cname = "cpBodyGetVelAtLocalPoint")]
		public cp.Vect get_vel_at_local_point (cp.Vect point);
		[CCode (cname = "cpBodyGetVelAtWorldPoint")]
		public cp.Vect get_vel_at_world_point (cp.Vect point);
		[CCode (cname = "cpBodyInitStatic")]
		public unowned cp.Body init_static ();
		[CCode (cname = "cpBodyNewStatic")]
		public static unowned cp.Body new_static ();
		[CCode (cname = "cpBodyResetForces")]
		public void reset_forces ();
		[CCode (cname = "cpBodySanityCheck")]
		public void sanity_check ();
		[CCode (cname = "cpBodySetAngle")]
		public void set_angle (double a);
		[CCode (cname = "cpBodySetMass")]
		public void set_mass (double m);
		[CCode (cname = "cpBodySetMoment")]
		public void set_moment (double i);
		[CCode (cname = "cpBodySetPos")]
		public void set_pos (cp.Vect pos);
		[CCode (cname = "cpBodySleep")]
		public void sleep ();
		[CCode (cname = "cpBodySleepWithGroup")]
		public void sleep_with_group (cp.Body group);
		[CCode (cname = "cpBodyUpdatePosition")]
		public void update_position (double dt);
		[CCode (cname = "cpBodyUpdateVelocity")]
		public void update_velocity (cp.Vect gravity, double damping, double dt);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class CircleShape : cp.Shape {
		public cp.Vect c;
		public double r;
		public weak cp.Shape shape;
		public cp.Vect tc;
		
		[CCode (cname = "cpCircleShapeNew")]
		public CircleShape (cp.Body body, double radius, cp.Vect offset);
		[CCode (cname = "cpCircleShapeGetOffset")]
		public cp.Vect shape_get_offset ();
		[CCode (cname = "cpCircleShapeGetRadius")]
		public double shape_get_radius ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class CollisionHandler {
		public cp.CollisionType a;
		public cp.CollisionType b;
		public weak cp.CollisionBeginFunc begin;
		public void* data;
		public weak cp.CollisionPostSolveFunc post_solve;
		public weak cp.CollisionPreSolveFunc pre_solve;
		public weak cp.CollisionSeparateFunc separate;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ComponentNode {
		public double idle_time;
		public weak cp.Body next;
		public weak cp.Body root;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpConstraintFree")]
	[Compact]
	public class Constraint {
		public weak cp.Body a;
		public weak cp.Body b;
		public void* data;
		public double error_bias;
		public weak cp.ConstraintClass klass_private;
		public double max_bias;
		public double max_force;
		public weak cp.Constraint next_a_private;
		public weak cp.Constraint next_b_private;
		public weak cp.ConstraintPostSolveFunc post_solve;
		public weak cp.ConstraintPreSolveFunc pre_solve;
		public weak cp.Space space_private;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ConstraintClass {
		public weak cp.ConstraintApplyCachedImpulseImpl apply_cached_impulse;
		public weak cp.ConstraintApplyImpulseImpl apply_impulse;
		public weak cp.ConstraintGetImpulseImpl get_impulse;
		public weak cp.ConstraintPreStepImpl pre_step;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class Contact {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ContactBufferHeader {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ContactPointSet {
		public int count;
		public void* points;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class DampedRotarySpring : cp.Constraint {
		public weak cp.Constraint constraint;
		public double damping;
		public double i_sum;
		public double j_acc;
		public double rest_angle;
		public weak cp.DampedRotarySpringTorqueFunc spring_torque_func;
		public double stiffness;
		public double target_wrn;
		public double w_coef;
		
		[CCode (cname = "cpDampedRotarySpringNew")]
		public DampedRotarySpring (cp.Body a, cp.Body b, double restAngle, double stiffness, double damping);
		[CCode (cname = "cpDampedRotarySpringGetClass")]
		public static unowned cp.ConstraintClass get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class DampedSpring : cp.Constraint {
		public cp.Vect anchr1;
		public cp.Vect anchr2;
		public weak cp.Constraint constraint;
		public double damping;
		public double j_acc;
		public cp.Vect n;
		public double n_mass;
		public cp.Vect r1;
		public cp.Vect r2;
		public double rest_length;
		public weak cp.DampedSpringForceFunc spring_force_func;
		public double stiffness;
		public double target_vrn;
		public double v_coef;
		
		[CCode (cname = "cpDampedSpringNew")]
		public DampedSpring (cp.Body a, cp.Body b, cp.Vect anchr1, cp.Vect anchr2, double restLength, double stiffness, double damping);
		[CCode (cname = "cpDampedSpringGetClass")]
		public static unowned cp.ConstraintClass get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class GearJoint : cp.Constraint {
		public double bias;
		public weak cp.Constraint constraint;
		public double i_sum;
		public double j_acc;
		public double phase;
		public double ratio;
		public double ratio_inv;
		
		[CCode (cname = "cpGearJointNew")]
		public GearJoint (cp.Body a, cp.Body b, double phase, double ratio);
		[CCode (cname = "cpGearJointGetClass")]
		public static unowned cp.ConstraintClass get_class ();
		[CCode (cname = "cpGearJointSetRatio")]
		public void set_ratio (double value);
		//public static void set_ratio (cp.Constraint constraint, double value);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class GrooveJoint : cp.Constraint {
		public cp.Vect anchr2;
		public cp.Vect bias;
		public double clamp;
		public weak cp.Constraint constraint;
		public cp.Vect grv_a;
		public cp.Vect grv_b;
		public cp.Vect grv_n;
		public cp.Vect grv_tn;
		public cp.Vect j_acc;
		public weak cp.Mat2x2 k;
		public cp.Vect r1;
		public cp.Vect r2;
		
		[CCode (cname = "cpGrooveJointNew")]
		public GrooveJoint (cp.Body a, cp.Body b, cp.Vect groove_a, cp.Vect groove_b, cp.Vect anchr2);
		[CCode (cname = "cpGrooveJointGetClass")]
		public static unowned cp.ConstraintClass get_class ();
		[CCode (cname = "cpGrooveJointSetGrooveA")]
		public void set_groove_a (cp.Vect value);
		//public static void set_groove_a (cp.Constraint constraint, cp.Vect value);
		[CCode (cname = "cpGrooveJointSetGrooveB")]
		public void set_groove_b (cp.Vect value);
		//public static void set_groove_b (cp.Constraint constraint, cp.Vect value);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpHashSetFree")]
	[Compact]
	public class HashSet {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class Mat2x2 {
		public double a;
		public double b;
		public double c;
		public double d;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class NearestPointQueryInfo {
		public double d;
		public cp.Vect p;
		public weak cp.Shape shape;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class PinJoint : cp.Constraint {
		public cp.Vect anchr1;
		public cp.Vect anchr2;
		public double bias;
		public weak cp.Constraint constraint;
		public double dist;
		public double jn_acc;
		public cp.Vect n;
		public double n_mass;
		public cp.Vect r1;
		public cp.Vect r2;
		
		[CCode (cname = "cpPinJointNew")]
		public PinJoint (cp.Body a, cp.Body b, cp.Vect anchr1, cp.Vect anchr2);
		[CCode (cname = "cpPinJointGetClass")]
		public static unowned cp.ConstraintClass get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class PivotJoint : cp.Constraint {
		public cp.Vect anchr1;
		public cp.Vect anchr2;
		public cp.Vect bias;
		public weak cp.Constraint constraint;
		public cp.Vect j_acc;
		public weak cp.Mat2x2 k;
		public cp.Vect r1;
		public cp.Vect r2;
		
		[CCode (cname = "cpPivotJointNew")]
		public PivotJoint (cp.Body a, cp.Body b, cp.Vect pivot);
		[CCode (cname = "cpPivotJointGetClass")]
		public static unowned cp.ConstraintClass get_class ();
		[CCode (cname = "cpPivotJointNew2")]
		public PivotJoint.two (cp.Body a, cp.Body b, cp.Vect anchr1, cp.Vect anchr2);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class PolyShape : cp.Shape {
		public int num_verts;
		public weak cp.SplittingPlane planes;
		public weak cp.Shape shape;
		public weak cp.SplittingPlane t_planes;
		public cp.Vect t_verts;
		[CCode (array_length = false)]
		public weak cp.Vect[] verts;
		
		[CCode (cname = "cpPolyShapeNew")]
		public PolyShape (cp.Body body, [CCode (array_length_pos = 1.9)] cp.Vect[] verts, cp.Vect offset);
		[CCode (cname = "cpPolyShapeGetNumVerts")]
		public int get_num_verts ();
		//public static int get_num_verts (cp.Shape shape);
		[CCode (cname = "cpPolyShapeGetVert")]
		public cp.Vect get_vert (int idx);
		//public static cp.Vect get_vert (cp.Shape shape, int idx);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class RatchetJoint : cp.Constraint {
		public double angle;
		public double bias;
		public weak cp.Constraint constraint;
		public double i_sum;
		public double j_acc;
		public double phase;
		public double ratchet;
		
		[CCode (cname = "cpRatchetJointNew")]
		public RatchetJoint (cp.Body a, cp.Body b, double phase, double ratchet);
		[CCode (cname = "cpRatchetJointGetClass")]
		public static unowned cp.ConstraintClass joint_get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class RotaryLimitJoint : cp.Constraint {
		public double bias;
		public weak cp.Constraint constraint;
		public double i_sum;
		public double j_acc;
		public double max;
		public double min;
		
		[CCode (cname = "cpRotaryLimitJointNew")]
		public RotaryLimitJoint (cp.Body a, cp.Body b, double min, double max);
		[CCode (cname = "cpRotaryLimitJointGetClass")]
		public static unowned cp.ConstraintClass get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class SegmentShape : cp.Shape {
		public cp.Vect a;
		public cp.Vect a_tangent;
		public cp.Vect b;
		public cp.Vect b_tangent;
		public cp.Vect n;
		public double r;
		public weak cp.Shape shape;
		public cp.Vect ta;
		public cp.Vect tb;
		public cp.Vect tn;
		
		[CCode (cname = "cpSegmentShapeNew")]
		public SegmentShape (cp.Body body, cp.Vect a, cp.Vect b, double radius);
		[CCode (cname = "cpSegmentShapeGetA")]
		public cp.Vect get_a ();
		[CCode (cname = "cpSegmentShapeGetB")]
		public cp.Vect get_b ();
		[CCode (cname = "cpSegmentShapeGetNormal")]
		public cp.Vect get_normal ();
		[CCode (cname = "cpSegmentShapeGetRadius")]
		public double get_radius ();
		[CCode (cname = "cpSegmentShapeSetNeighbors")]
		public void set_neighbors (cp.Vect prev, cp.Vect next);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpShapeFree")]
	[Compact]
	public class Shape {
		public cp.BB bb;
		public weak cp.Body body;
		public cp.CollisionType collision_type;
		public void* data;
		public double e;
		public cp.Group group;
		public cp.HashValue hashid_private;
		public weak cp.ShapeClass klass_private;
		public cp.Layers layers;
		public weak cp.Shape next_private;
		public weak cp.Shape prev_private;
		public weak bool sensor;
		public weak cp.Space space_private;
		public cp.Vect surface_v;
		public double u;
		
		[CCode (cname = "cpShapeCacheBB")]
		public cp.BB cache_b_b ();
		[CCode (cname = "cpShapeNearestPointQuery")]
		public double nearest_point_query (cp.Vect p, cp.NearestPointQueryInfo @out);
		[CCode (cname = "cpShapePointQuery")]
		public bool point_query (cp.Vect p);
		[CCode (cname = "cpShapeSegmentQuery")]
		public bool segment_query (cp.Vect a, cp.Vect b, cp.SegmentQueryInfo info);
		[CCode (cname = "cpShapeSetBody")]
		public void set_body (cp.Body body);
		[CCode (cname = "cpShapeUpdate")]
		public cp.BB update (cp.Vect pos, cp.Vect rot);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ShapeClass {
		public weak cp.ShapeCacheDataImpl cache_data;
		public weak cp.ShapeDestroyImpl destroy;
		public weak cp.ShapeNearestPointQueryImpl nearest_point_query;
		public weak cp.ShapeSegmentQueryImpl segment_query;
		public cp.ShapeType type;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class SimpleMotor : cp.Constraint {
		public weak cp.Constraint constraint;
		public double i_sum;
		public double j_acc;
		public double rate;
		
		[CCode (cname = "cpSimpleMotorNew")]
		public SimpleMotor (cp.Body a, cp.Body b, double rate);
		[CCode (cname = "cpSimpleMotorGetClass")]
		public static unowned cp.ConstraintClass get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class SlideJoint : cp.Constraint {
		public cp.Vect anchr1;
		public cp.Vect anchr2;
		public double bias;
		public weak cp.Constraint constraint;
		public double jn_acc;
		public double max;
		public double min;
		public cp.Vect n;
		public double n_mass;
		public cp.Vect r1;
		public cp.Vect r2;
		
		[CCode (cname = "cpSlideJointNew")]
		public SlideJoint (cp.Body a, cp.Body b, cp.Vect anchr1, cp.Vect anchr2, double min, double max);
		[CCode (cname = "cpSlideJointGetClass")]
		public static unowned cp.ConstraintClass get_class ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpSpaceFree")]
	[Compact]
	public class Space {
		public weak cp.SpatialIndex active_shapes_private;
		public weak cp.Array allocated_buffers_private;
		public weak cp.Array arbiters_private;
		public weak cp.Array bodies_private;
		public weak cp.HashSet cached_arbiters_private;
		public double collision_bias;
		public weak cp.HashSet collision_handlers_private;
		public weak cp.Timestamp collision_persistence;
		public double collision_slop;
		public weak cp.Array constraints_private;
		public weak cp.ContactBufferHeader contact_buffers_head_private;
		public double curr_dt_private;
		public double damping;
		public void* data;
		public weak cp.CollisionHandler default_handler_private;
		public weak bool enable_contact_graph;
		public cp.Vect gravity;
		public double idle_speed_threshold;
		public int iterations;
		public int locked_private;
		public weak cp.Array pooled_arbiters_private;
		public weak cp.Array post_step_callbacks_private;
		public weak cp.Array roused_bodies_private;
		public weak bool skip_post_step_private;
		public double sleep_time_threshold;
		public weak cp.Array sleeping_components_private;
		public weak cp.Timestamp stamp_private;
		[CCode (cname = "staticBody")] public weak cp.Body static_body;
		public weak cp.SpatialIndex static_shapes_private;
		
		[CCode (cname = "cpSpaceNew")]
		public Space ();
		[CCode (cname = "cpSpaceActivateShapesTouchingShape")]
		public void activate_shapes_touching_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceAddBody")]
		public unowned cp.Body add_body (cp.Body body);
		[CCode (cname = "cpSpaceAddCollisionHandler")]
		public void add_collision_handler (cp.CollisionType a, cp.CollisionType b, cp.CollisionBeginFunc begin, cp.CollisionPreSolveFunc pre_solve, cp.CollisionPostSolveFunc post_solve, cp.CollisionSeparateFunc separate, void* data);
		[CCode (cname = "cpSpaceAddConstraint")]
		public unowned cp.Constraint add_constraint (cp.Constraint constraint);
		[CCode (cname = "cpSpaceAddPostStepCallback")]
		public bool add_post_step_callback (cp.PostStepFunc func, void* key, void* data);
		[CCode (cname = "cpSpaceAddShape")]
		public unowned cp.Shape add_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceAddStaticShape")]
		public unowned cp.Shape add_static_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceBBQuery")]
		public void b_b_query (cp.BB bb, cp.Layers layers, cp.Group group, cp.SpaceBBQueryFunc func, void* data);
		[CCode (cname = "cpSpaceContainsBody")]
		public bool contains_body (cp.Body body);
		[CCode (cname = "cpSpaceContainsConstraint")]
		public bool contains_constraint (cp.Constraint constraint);
		[CCode (cname = "cpSpaceContainsShape")]
		public bool contains_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceEachBody")]
		public void each_body (cp.SpaceBodyIteratorFunc func, void* data);
		[CCode (cname = "cpSpaceEachConstraint")]
		public void each_constraint (cp.SpaceConstraintIteratorFunc func, void* data);
		[CCode (cname = "cpSpaceEachShape")]
		public void each_shape (cp.SpaceShapeIteratorFunc func, void* data);
		[CCode (cname = "cpSpaceNearestPointQuery")]
		public void nearest_point_query (cp.Vect point, double max_distance, cp.Layers layers, cp.Group group, cp.SpaceNearestPointQueryFunc func, void* data);
		[CCode (cname = "cpSpaceNearestPointQueryNearest")]
		public unowned cp.Shape nearest_point_query_nearest (cp.Vect point, double max_distance, cp.Layers layers, cp.Group group, cp.NearestPointQueryInfo @out);
		[CCode (cname = "cpSpacePointQuery")]
		public void point_query (cp.Vect point, cp.Layers layers, cp.Group group, cp.SpacePointQueryFunc func, void* data);
		[CCode (cname = "cpSpacePointQueryFirst")]
		public unowned cp.Shape point_query_first (cp.Vect point, cp.Layers layers, cp.Group group);
		[CCode (cname = "cpSpaceReindexShape")]
		public void reindex_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceReindexShapesForBody")]
		public void reindex_shapes_for_body (cp.Body body);
		[CCode (cname = "cpSpaceReindexStatic")]
		public void reindex_static ();
		[CCode (cname = "cpSpaceRemoveBody")]
		public void remove_body (cp.Body body);
		[CCode (cname = "cpSpaceRemoveCollisionHandler")]
		public void remove_collision_handler (cp.CollisionType a, cp.CollisionType b);
		[CCode (cname = "cpSpaceRemoveConstraint")]
		public void remove_constraint (cp.Constraint constraint);
		[CCode (cname = "cpSpaceRemoveShape")]
		public void remove_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceRemoveStaticShape")]
		public void remove_static_shape (cp.Shape shape);
		[CCode (cname = "cpSpaceSegmentQuery")]
		public void segment_query (cp.Vect start, cp.Vect end, cp.Layers layers, cp.Group group, cp.SpaceSegmentQueryFunc func, void* data);
		[CCode (cname = "cpSpaceSegmentQueryFirst")]
		public unowned cp.Shape segment_query_first (cp.Vect start, cp.Vect end, cp.Layers layers, cp.Group group, cp.SegmentQueryInfo @out);
		[CCode (cname = "cpSpaceSetDefaultCollisionHandler")]
		public void set_default_collision_handler (cp.CollisionBeginFunc begin, cp.CollisionPreSolveFunc pre_solve, cp.CollisionPostSolveFunc post_solve, cp.CollisionSeparateFunc separate, void* data);
		[CCode (cname = "cpSpaceShapeQuery")]
		public bool shape_query (cp.Shape shape, cp.SpaceShapeQueryFunc func, void* data);
		[CCode (cname = "cpSpaceStep")]
		public void step (double dt);
		[CCode (cname = "cpSpaceUseSpatialHash")]
		public void use_spatial_hash (double dim, int count);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", free_function = "cpSpaceHashFree")]
	[Compact]
	public class SpaceHash {
		[CCode (cname = "cpSpaceHashResize")]
		public void hash_resize (double celldim, int numcells);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class SpatialIndex {
		public weak cp.SpatialIndexBBFunc bbfunc;
		public weak cp.SpatialIndex dynamic_index;
		public weak cp.SpatialIndexClass klass;
		public weak cp.SpatialIndex static_index;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class SpatialIndexClass {
		public weak cp.SpatialIndexContainsImpl contains;
		public weak cp.SpatialIndexCountImpl count;
		public weak cp.SpatialIndexDestroyImpl destroy;
		public weak cp.SpatialIndexEachImpl each;
		public weak cp.SpatialIndexInsertImpl insert;
		public weak cp.SpatialIndexQueryImpl query;
		public weak cp.SpatialIndexReindexImpl reindex;
		public weak cp.SpatialIndexReindexObjectImpl reindex_object;
		public weak cp.SpatialIndexReindexQueryImpl reindex_query;
		public weak cp.SpatialIndexRemoveImpl remove;
		public weak cp.SpatialIndexSegmentQueryImpl segment_query;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class SplittingPlane {
		public double d;
		public cp.Vect n;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class Sweep1D {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class Timestamp {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class blkcnt_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class blksize_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class caddr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class clock_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class clockid_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class daddr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class dev_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class div_t {
		public int quot;
		public int rem;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class double_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class fd_mask {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class fd_set {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class float_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class fsblkcnt_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class fsfilcnt_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class fsid_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class gid_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class id_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ino_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_fast16_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_fast32_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_fast64_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_fast8_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_least16_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_least32_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_least64_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class int_least8_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class intmax_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class intptr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class key_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ldiv_t {
		public long quot;
		public long rem;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class lldiv_t {
		public long quot;
		public long rem;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class loff_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class mode_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class nlink_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class off_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pid_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_attr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_barrier_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_barrierattr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_condattr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_key_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_mutexattr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_once_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_rwlock_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_rwlockattr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_spinlock_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class pthread_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class quad_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class sigset_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class size_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ssize_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class suseconds_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class time_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class timer_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class u_char {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class u_int {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class u_long {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class u_quad_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class u_short {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uid_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint16_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint32_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint64_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint8_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_fast16_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_fast32_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_fast64_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_fast8_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_least16_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_least32_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_least64_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uint_least8_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uintmax_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class uintptr_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ulong {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class ushort {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class wchar_t {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public struct Arbiter {
		public double e;
		public double u;
		public cp.Vect surface_vr;
		public void* data;
		public weak cp.Shape a_private;
		public weak cp.Shape b_private;
		public weak cp.Body body_a_private;
		public weak cp.Body body_b_private;
		public void* thread_a_private;
		public void* thread_b_private;
		public int num_contacts_private;
		public weak cp.Contact contacts_private;
		public weak cp.Timestamp stamp_private;
		public weak cp.CollisionHandler handler_private;
		public weak bool swapped_coll_private;
		public cp.ArbiterState state_private;
		
		[CCode (cname = "cpArbiterGetContactPointSet")]
		public unowned cp.ContactPointSet get_contact_point_set ();
		[CCode (cname = "cpArbiterGetCount")]
		public int get_count ();
		[CCode (cname = "cpArbiterGetDepth")]
		public double get_depth (int i);
		[CCode (cname = "cpArbiterGetNormal")]
		public cp.Vect get_normal (int i);
		[CCode (cname = "cpArbiterGetPoint")]
		public cp.Vect get_point (int i);
		[CCode (cname = "cpArbiterIgnore")]
		public void ignore ();
		[CCode (cname = "cpArbiterIsFirstContact")]
		public bool is_first_contact ();
		[CCode (cname = "cpArbiterTotalImpulse")]
		public cp.Vect total_impulse ();
		[CCode (cname = "cpArbiterTotalImpulseWithFriction")]
		public cp.Vect total_impulse_with_friction ();
		[CCode (cname = "cpArbiterTotalKE")]
		public double total_k_e ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	[SimpleType]
	public struct BB {
		public double l;
		public double b;
		public double r;
		public double t;
		
		[CCode (cname = "cpBBNew")]
		public BB (double l, double b, double r, double t);
		[CCode (cname = "cpBBWrapVect")]
		public cp.Vect wrap_vect (cp.Vect v);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[SimpleType]
	public struct CollisionType : uint {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[SimpleType]
	public struct Group : uint {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[SimpleType]
	public struct HashValue : uint {}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[SimpleType]
	public struct Layers : uint {}
	
	[CCode (cname = "cpMomentForBox")]
	public static double moment_for_box (double m, double width, double height);
	[CCode (cname = "cpMomentForBox2")]
	public static double moment_for_box2 (double m, cp.BB box);
	[CCode (cname = "cpMomentForCircle")]
	public static double moment_for_circle (double m, double r1, double r2, cp.Vect offset);
	[CCode (cname = "cpMomentForPoly")]
	public static double moment_for_poly (double m, int num_verts, [CCode (array_length_pos = 1.9)] cp.Vect[] verts, cp.Vect offset);
	[CCode (cname = "cpMomentForSegment")]
	public static double moment_for_segment (double m, cp.Vect a, cp.Vect b);
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public struct SegmentQueryInfo {
		public weak cp.Shape shape;
		public double t;
		public cp.Vect n;
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[SimpleType]
	public struct Vect {
		public double x;
		public double y;
		
		[CCode (cname = "cpvforangle")]
		public Vect.for_angle (double a);
		[CCode (cname = "cpvslerp")]
		public cp.Vect slerp (cp.Vect v2, double t);
		[CCode (cname = "cpvslerpconst")]
		public cp.Vect slerp_const (cp.Vect v2, double a);
		[CCode (cname = "cpvstr")]
		public unowned string to_string ();
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cprefix = "cpArbiterState", has_type_id = false)]
	public enum ArbiterState {
		[CCode (cname = "cpArbiterStateFirstColl")]
		FIRST_COLL,
		NORMAL,
		IGNORE,
		CACHED
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cprefix = "CP_", has_type_id = false)]
	public enum ShapeType {
		CIRCLE_SHAPE,
		SEGMENT_SHAPE,
		POLY_SHAPE,
		NUM_SHAPES
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate cp.Vect BBTreeVelocityFunc (void* obj);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void BodyArbiterIteratorFunc (cp.Body body, cp.Arbiter arbiter);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void BodyConstraintIteratorFunc (cp.Body body, cp.Constraint constraint);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void BodyPositionFunc (cp.Body body, double dt);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void BodyShapeIteratorFunc (cp.Body body, cp.Shape shape);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void BodyVelocityFunc (cp.Body body, cp.Vect gravity, double damping, double dt);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate bool CollisionBeginFunc (cp.Arbiter arb, cp.Space space);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void CollisionPostSolveFunc (cp.Arbiter arb, cp.Space space);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate bool CollisionPreSolveFunc (cp.Arbiter arb, cp.Space space);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void CollisionSeparateFunc (cp.Arbiter arb, cp.Space space);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ConstraintApplyCachedImpulseImpl (cp.Constraint constraint, double dt_coef);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ConstraintApplyImpulseImpl (cp.Constraint constraint, double dt);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate double ConstraintGetImpulseImpl (cp.Constraint constraint);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ConstraintPostSolveFunc (cp.Constraint constraint, cp.Space space);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ConstraintPreSolveFunc (cp.Constraint constraint, cp.Space space);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ConstraintPreStepImpl (cp.Constraint constraint, double dt);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate double DampedRotarySpringTorqueFunc (cp.DampedRotarySpring spring, double relative_angle);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate double DampedSpringForceFunc (cp.DampedSpring spring, double dist);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void PostStepFunc (cp.Space space, void* key);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate cp.BB ShapeCacheDataImpl (cp.Shape shape, cp.Vect p, cp.Vect rot);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ShapeDestroyImpl (cp.Shape shape);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ShapeNearestPointQueryImpl (cp.Shape shape, cp.Vect p, cp.NearestPointQueryInfo info);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void ShapeSegmentQueryImpl (cp.Shape shape, cp.Vect a, cp.Vect b, cp.SegmentQueryInfo info);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void SpaceArbiterApplyImpulseFunc (cp.Arbiter arb);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceBBQueryFunc (cp.Shape shape);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceBodyIteratorFunc (cp.Body body);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceConstraintIteratorFunc (cp.Constraint constraint);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceNearestPointQueryFunc (cp.Shape shape, double distance, cp.Vect point);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpacePointQueryFunc (cp.Shape shape);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceSegmentQueryFunc (cp.Shape shape, double t, cp.Vect n);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceShapeIteratorFunc (cp.Shape shape);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpaceShapeQueryFunc (cp.Shape shape, cp.ContactPointSet points);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate cp.BB SpatialIndexBBFunc (void* obj);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate bool SpatialIndexContainsImpl (cp.SpatialIndex index, void* obj, cp.HashValue hashid);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate int SpatialIndexCountImpl (cp.SpatialIndex index);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void SpatialIndexDestroyImpl (cp.SpatialIndex index);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpatialIndexEachImpl (cp.SpatialIndex index, cp.SpatialIndexIteratorFunc func);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void SpatialIndexInsertImpl (cp.SpatialIndex index, void* obj, cp.HashValue hashid);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpatialIndexIteratorFunc (void* obj);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpatialIndexQueryFunc (void* obj1, void* obj2);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpatialIndexQueryImpl (cp.SpatialIndex index, void* obj, cp.BB bb, cp.SpatialIndexQueryFunc func);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void SpatialIndexReindexImpl (cp.SpatialIndex index);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void SpatialIndexReindexObjectImpl (cp.SpatialIndex index, void* obj, cp.HashValue hashid);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpatialIndexReindexQueryImpl (cp.SpatialIndex index, cp.SpatialIndexQueryFunc func);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", has_target = false)]
	public delegate void SpatialIndexRemoveImpl (cp.SpatialIndex index, void* obj, cp.HashValue hashid);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate double SpatialIndexSegmentQueryFunc (void* obj1, void* obj2);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public delegate void SpatialIndexSegmentQueryImpl (cp.SpatialIndex index, void* obj, cp.Vect a, cp.Vect b, double t_exit, cp.SpatialIndexSegmentQueryFunc func);
	
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public static void init ();
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public static void message (string condition, string file, int line, int is_error, int is_hard_error, string message);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public static bool poly_validate ([CCode (array_length_pos = 1.9)] cp.Vect[] verts, int num_verts);
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	public static void reset_shapeId_counter ();
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpAreaForCircle")]
	public static double area_for_circle (double r1, double r2);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpAreaForPoly")]
	public static double area_for_poly (int num_verts, out cp.Vect verts);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpAreaForSegment")]
	public static double area_for_segment (cp.Vect a, cp.Vect b, double r);
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h")]
	[Compact]
	public class BoxShape : cp.PolyShape {
		[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpBoxShapeInit2")]
		public unowned cp.BoxShape init2 (cp.Body body, cp.BB box);
		[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpBoxShapeNew2")]
		public static BoxShape (cp.Body body, cp.BB box);
	}
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpCentroidForPoly")]
	public static cp.Vect centroid_for_poly (int num_verts, out cp.Vect verts);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpConvexHull")]
	public static int convex_hull (int count, out cp.Vect verts, out cp.Vect _result, int first, double tol);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpEnableSegmentToSegmentCollisions")]
	public static void enable_segment_to_segment_collisions ();
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpRecenterPoly")]
	public static void recenter_poly (int num_verts, out cp.Vect verts);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "cpSpatialIndexCollideStatic")]
	public static void spatial_index_collide_static (cp.SpatialIndex dynamic_index, cp.SpatialIndex static_index, cp.SpatialIndexQueryFunc func, void* data);
	
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "matherr")]
	public static int matherr (void* __exc);
	[CCode (cheader_filename = "chipmunk/chipmunk.h", cname = "system")]
	public static int system (string __command);
}
