local Vehicle = { }

Vehicle.ID = 1

Vehicle.Name = "Subaru Impreza"

Vehicle.Script = "impreza"

Vehicle.Model = "models/lonewolfie/subaru_22b.mdl"

Vehicle.Price = 150000

Vehicle.PassengerSeats = {	Vector(-15.80, -4.71, 16.57),
							Vector(16.54, -39, 22.05),
							Vector(0, -39, 22.239999771118),
							Vector(-17.78, -39, 22.23)
						}

Vehicle.ExitPoint = { 	Vector(60, 2.44, 34.16),
						Vector(-65.29, -11.18, 39.22),
						Vector(-65.29, -11.18, 39.22),
						Vector(-65.29, -11.18, 39.22),
						Vector(60, 2.44, 34.16),
						}


Vehicle.LookAt = Vector(33, 0, 0)

Vehicle.Seats = 5

Vehicle.MaxSpeed = 80

Vehicle.CamPos = Vector(-58, 150, 59)

Vehicle.FOV = 54

GM:LoadVehicle(Vehicle)

local Vehicle = { }

Vehicle.ID = 2

Vehicle.Name = "Porsche 911 Turbo"

Vehicle.Script = "911turbo"

Vehicle.Model = "models/sentry/911turbo.mdl"

Vehicle.Price = 200000

Vehicle.PassengerSeats = {	Vector(14.28, 3.40, 16.47),
							Vector(10.77, -34.16, 21.39),
							Vector(-12.18, -34.16, 21.39) }

Vehicle.ExitPoint = { 	Vector(-65.29, -11.18, 39.22),
						Vector(61.47, 3.30, 24.56),
						Vector(61.47, 3.30, 24.56),
						Vector(-65.29, -11.18, 39.22) }

Vehicle.LookAt = Vector(33, 0, 0)

Vehicle.Seats = 2

Vehicle.MaxSpeed = 160

Vehicle.CamPos = Vector(-58, 150, 59)

Vehicle.FOV = 54

GM:LoadVehicle(Vehicle)