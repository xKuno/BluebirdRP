-- Change 'false' to 'true' to toggle the engine automatically on when entering a vehicle
OnAtEnter = false

-- Change 'false' to 'true' to use a key instead of a button
UseKey = true

if UseKey then
	-- Change this to change the key to toggle the engine (Other Keys at wiki.fivem.net/wiki/Controls)
	ToggleKey = 303
end

cfg = {
	smoothDriving = true,					-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable.
	stopWithoutReversing = true,			-- The stop-without-reversing and brake-light-hold feature does also work for keyboards.
	smoothAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	smoothBrakeCurve = 5.0					-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers
}
