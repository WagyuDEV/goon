package main

import "core:fmt"

import rl "vendor:raylib"

Window :: struct {
	name:          cstring,
	width:         i32,
	height:        i32,
	fps:           i32,
	control_flags: rl.ConfigFlags,
}

Mouse :: struct {
    x:  i32,
    y: i32,
}

Player :: struct {
    Camera: rl.Camera3D,
    Health: i32,
}

Camera := rl.Camera3D{
    position=rl.Vector3{200,200,200},
    target=rl.Vector3{0,0,0},
    up=rl.Vector3{0,1,0},
    fovy=90,
    projection=rl.CameraProjection.PERSPECTIVE
}

main :: proc() {
    window := Window{"Goon", 1280, 720, 999, rl.ConfigFlags{.WINDOW_RESIZABLE}}
    mouse := Mouse{rl.GetMouseX(), rl.GetMouseY()}

    rl.InitWindow(window.width, window.height, window.name)
    rl.SetWindowState(window.control_flags)
    rl.SetTargetFPS(window.fps)

    for !rl.WindowShouldClose(){

        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        rl.DrawFPS(0,0)
        // rl.DrawCircle(mouse.x,mouse.y, 10, rl.RED)

        // if rl.IsKeyDown(rl.KeyboardKey.W){

        // }

        if rl.IsKeyDown(rl.KeyboardKey.W) {
            Camera.position.z -= 1 // Move forward along the Z-axis
            Camera.target.z -= 1  // Move the target in the same direction
        }
        if rl.IsKeyDown(rl.KeyboardKey.S) {
            Camera.position.z += 1 // Move backward along the Z-axis
            Camera.target.z += 1   // Move the target in the same direction
        }
        if rl.IsKeyDown(rl.KeyboardKey.A) {
            Camera.position.x -= 1 // Move left along the X-axis
            Camera.target.x -= 1   // Move the target in the same direction
        }
        if rl.IsKeyDown(rl.KeyboardKey.D) {
            Camera.position.x += 1 // Move right along the X-axis
            Camera.target.x += 1   // Move the target in the same direction
        }

        rl.BeginMode3D(Camera)
        rl.DrawCubeWires(rl.Vector3{0,0,0}, 100, 100, 100, rl.BLUE)
        rl.EndMode3D()

        rl.EndDrawing()
    }
}