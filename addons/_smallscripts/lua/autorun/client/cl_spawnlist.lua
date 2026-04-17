-- 17.04
hook.Add("PopulatePropMenu", "WayZer Prop", function()
	local contents = {}

	--Пропы
	table.insert( contents, {
		type = "header",
		text = "Двери"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/door01_left.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_c17/door02_double.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_doors/door03_slotted_left.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/prison_celldoor001a.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_borealis/borealis_door001a.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_interiors/elevatorshaft_door01a.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_c17/gate_door01a.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_lab/blastdoor001a.model"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_building_details/Storefront_Template001a_Bars.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props_lab/blastdoor001c.mdl"
	} )
----------------
	table.insert( contents, {
		type = "header",
		text = "Мебель"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureCouch001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureCouch002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/couch.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_Couch01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_Couch02a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_Couch01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/sofa.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/sofa_chair.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Chair_office.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureChair001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/chair02a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_combine/breenchair.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_chair01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_chair03a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/controlroom_chair001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_combine/breenchair.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/barstool01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Table_coffee.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Table_meeting.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/table_shed.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/table_kitchen.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureTable002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureTable003a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureTable001a.mdl" -- models/props/CS_militia/wood_table.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/wood_table.mdl" -- models/props/CS_militia/wood_table.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/table_kitchen.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_Desk01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_combine/breendesk.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/controlroom_desk001b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/bar01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/wood_bench.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/cafeteria_bench001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_trainstation/BenchOutdoor01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_trainstation/bench_indoor001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureCupboard001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureDrawer001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureDrawer002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureDrawer003a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureDresser001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/shelfunit01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_shelf01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/prison_bedframe001b.mdl"
	} )
---------
	table.insert( contents, {
		type = "header",
		text = "Ванная Комната"
	} )

	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureToilet001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureSink001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/BathTub01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/laundry_dryer002.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/toothbrushset01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/urine_trough.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/toilet.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/CS_militia/dryer.mdl" -- models/props_c17/FurnitureBathtub001a.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureBathtub001a.mdl" -- models/props_c17/FurnitureBathtub001a.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/prison_toilet01.mdl" -- models/props_c17/FurnitureBathtub001a.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/SinkKitchen01a.mdl"
	} )
---------
	table.insert( contents, {
		type = "header",
		text = "Забор"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/fence01b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/fence01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/fence03a.mdl" -- models/props_wasteland/exterior_fence003a.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/exterior_fence003a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/exterior_fence002b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/exterior_fence002c.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/exterior_fence002d.mdl" -- models/props_wasteland/exterior_fence002e.mdl
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/exterior_fence002e.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/exterior_fence002e.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence001b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence001c.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence001d.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence001e.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence002b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence002c.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/interior_fence002e.mdl"
	} )
-----------------------
	table.insert( contents, {
		type = "header",
		text = "Декор/Электроника"
	} )

	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureFridge001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/furnitureStove001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureWashingmachine001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/VendingMachineSoda01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/tv_monitor01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/monitor01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/monitor01b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/monitor02.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/computer_monitor.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/computer.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/computer_caseB.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/harddrive02.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/harddrive01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_combine/breenclock.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_combine/breenglobe.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offcertificatea.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offcorkboarda.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offinspa.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offinspb.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offinspc.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offinspd.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offinspf.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offinspg.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintinga.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintingb.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintingd.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintinge.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintingf.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintingh.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/offpaintingi.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/phone.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/projector.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/projector_remote.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/radio.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/TV_plasma.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/de_nuke/clock.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/clock01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Shelves_metal.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Shelves_metal1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Shelves_metal2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/Shelves_metal3.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/plant01.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/cactus.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/file_box.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/file_cabinet1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/file_cabinet1_group.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/file_cabinet2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/file_cabinet3.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/TrashBin01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/TrashDumpster01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_trainstation/trashcan_indoor001b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_trainstation/trashcan_indoor001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_Lamp01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/PlasticCrate01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/PlasticCrate01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/concrete_barrier001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/display_cooler01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/FurnitureShelf002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/Lockers001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_c17/metalladder001.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_interiors/Furniture_Vanity01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/wood_crate001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/wood_crate001a_damaged.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/wood_crate002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/wood_pallet001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/kitchen_fridge001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/kitchen_counter001c.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/kitchen_counter001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/kitchen_stove001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_wasteland/kitchen_stove002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/garbage256_composite001a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/garbage256_composite001b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/garbage256_composite002a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/garbage256_composite002b.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_lab/citizenradio.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/trash_can.mdl"
	} )
    table.insert( contents, {
		type = "model",
		model = "models/props/cs_office/microwave.mdl"
	} )
-----------------------
	table.insert( contents, {
		type = "header",
		text = "Плиты"
	} )

	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_plate1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_plate1x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_plate2x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_plate4x4.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_tube.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_tubex2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_wire1x1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_wire1x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/metal_wire2x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/glass/glass_plate1x1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/glass/glass_plate1x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/glass/glass_plate2x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/windows/window1x1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/windows/window1x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/windows/window2x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/windows/window4x4.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/wood/wood_panel1x1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/wood/wood_panel1x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/wood/wood_panel2x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_phx/construct/wood/wood_panel4x4.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate1x1.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate1x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate1x3.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate1x4.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate2x2.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate2x3.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate2x4.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate3x3.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate3x4.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/hunter/plates/plate4x4.mdl"
	} )
	
	table.insert( contents, {
		type = "header",
		text = "Транспорт"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/buggy.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_junk/bicycle01a.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/xqm/jetbody3.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/xqm/coastertrain2seat.mdl"
	} )
	table.insert( contents, {
		type = "model",
		model = "models/props_canal/boat002b.mdl"
	} )
	spawnmenu.AddPropCategory( "TwoOfEach", "WayZer Prop", contents, "icon16/box.png" )
end)

local function removeOldTabls()
  for k, v in pairs( g_SpawnMenu.CreateMenu.Items ) do

     if (v.Tab:GetText() == language.GetPhrase("spawnmenu.category.npcs") or

         v.Tab:GetText() == language.GetPhrase("spawnmenu.category.postprocess") or

         v.Tab:GetText() == language.GetPhrase("spawnmenu.category.dupes") or

         v.Tab:GetText() == language.GetPhrase("spawnmenu.category.saves")) then

         g_SpawnMenu.CreateMenu:CloseTab( v.Tab, true )

         removeOldTabls()

	end
 end
end

hook.Add("SpawnMenuOpen", "blockmenutabs", removeOldTabls)