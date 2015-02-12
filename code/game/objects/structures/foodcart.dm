/obj/structure/foodcart
	name = "food cart"
	desc = "A cart for transporting food and drinks."
	icon = 'icons/obj/foodcart.dmi'
	icon_state = "cart"
	anchored = 0
	density = 1
	//Food slots
	var/list/food_slots[6]
	//var/obj/item/weapon/reagent_containers/food/snacks/food1 = null
	//var/obj/item/weapon/reagent_containers/food/snacks/food2 = null
	//var/obj/item/weapon/reagent_containers/food/snacks/food3 = null
	//var/obj/item/weapon/reagent_containers/food/snacks/food4 = null
	//var/obj/item/weapon/reagent_containers/food/snacks/food5 = null
	//var/obj/item/weapon/reagent_containers/food/snacks/food6 = null
	//Drink slots
	var/list/drink_slots[6]
	//var/obj/item/weapon/reagent_containers/food/drinks/drink1 = null
	//var/obj/item/weapon/reagent_containers/food/drinks/drink2 = null
	//var/obj/item/weapon/reagent_containers/food/drinks/drink3 = null
	//var/obj/item/weapon/reagent_containers/food/drinks/drink4 = null
	//var/obj/item/weapon/reagent_containers/food/drinks/drink5 = null
	//var/obj/item/weapon/reagent_containers/food/drinks/drink6 = null

/obj/structure/foodcart/proc/put_in_cart(obj/item/I, mob/user)
	user.drop_item()
	I.loc = src
	updateUsrDialog()
	user << "<span class='notice'>You put [I] into [src].</span>"
	return

/obj/structure/foodcart/attackby(obj/item/I, mob/user)
	var/fail_msg = "<span class='notice'>There are no open spaces for this in [src].</span>"
	if(!I.is_robot_module())
		if(istype(I, /obj/item/weapon/reagent_containers/food/snacks))
			var/success = 0
			for(var/s=1,s<=6,s++)
				if(!food_slots[s])
					put_in_cart(I, user)
					food_slots[s]=I
					update_icon()
					success = 1
					break;
			if(!success)
				user << fail_msg
		else if(istype(I, /obj/item/weapon/reagent_containers/food/drinks))
			var/success = 0
			for(var/s=1,s<=6,s++)
				if(!drink_slots[s])
					put_in_cart(I, user)
					drink_slots[s]=I
					update_icon()
					success = 1
					break;
			if(!success)
				user << fail_msg
		else if(istype(I, /obj/item/weapon/wrench))
			if (!anchored && !isinspace())
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				user.visible_message( \
					"[user] tightens \the [src]'s casters.", \
					"<span class='notice'> You have tightened \the [src]'s casters.</span>", \
					"You hear ratchet.")
				anchored = 1
			else if(anchored)
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				user.visible_message( \
					"[user] loosens \the [src]'s casters.", \
					"<span class='notice'> You have loosened \the [src]'s casters.</span>", \
					"You hear ratchet.")
				anchored = 0
	else
		usr << "<span class='warning'>You cannot interface your modules [src]!</span>"

/obj/structure/foodcart/attack_hand(mob/user)
	user.set_machine(src)
	var/dat
	if(food_slots[1])
		dat += "<a href='?src=\ref[src];f1=1'>[food_slots[1]]</a><br>"
	if(food_slots[2])
		dat += "<a href='?src=\ref[src];f2=1'>[food_slots[2]]</a><br>"
	if(food_slots[3])
		dat += "<a href='?src=\ref[src];f3=1'>[food_slots[3]]</a><br>"
	if(food_slots[4])
		dat += "<a href='?src=\ref[src];f4=1'>[food_slots[4]]</a><br>"
	if(food_slots[5])
		dat += "<a href='?src=\ref[src];f5=1'>[food_slots[5]]</a><br>"
	if(food_slots[6])
		dat += "<a href='?src=\ref[src];f6=1'>[food_slots[6]]</a><br>"
	if(drink_slots[1])
		dat += "<a href='?src=\ref[src];d1=1'>[drink_slots[1]]</a><br>"
	if(drink_slots[2])
		dat += "<a href='?src=\ref[src];d2=1'>[drink_slots[2]]</a><br>"
	if(drink_slots[3])
		dat += "<a href='?src=\ref[src];d3=1'>[drink_slots[3]]</a><br>"
	if(drink_slots[4])
		dat += "<a href='?src=\ref[src];d4=1'>[drink_slots[4]]</a><br>"
	if(drink_slots[5])
		dat += "<a href='?src=\ref[src];d5=1'>[drink_slots[5]]</a><br>"
	if(drink_slots[6])
		dat += "<a href='?src=\ref[src];d6=1'>[drink_slots[6]]</a><br>"
	var/datum/browser/popup = new(user, "foodcart", name, 240, 160)
	popup.set_content(dat)
	popup.open()

/obj/structure/foodcart/Topic(href, href_list)
	if(!in_range(src, usr))
		return
	if(!isliving(usr))
		return
	var/mob/living/user = usr
	if(href_list["f1"])
		if(food_slots[1])
			user.put_in_hands(food_slots[1])
			user << "<span class='notice'>You take [food_slots[1]] from [src].</span>"
			food_slots[1] = null
	if(href_list["f2"])
		if(food_slots[2])
			user.put_in_hands(food_slots[2])
			user << "<span class='notice'>You take [food_slots[2]] from [src].</span>"
			food_slots[2] = null
	if(href_list["f3"])
		if(food_slots[3])
			user.put_in_hands(food_slots[3])
			user << "<span class='notice'>You take [food_slots[3]] from [src].</span>"
			food_slots[3] = null
	if(href_list["f4"])
		if(food_slots[4])
			user.put_in_hands(food_slots[4])
			user << "<span class='notice'>You take [food_slots[4]] from [src].</span>"
			food_slots[4] = null
	if(href_list["f5"])
		if(food_slots[5])
			user.put_in_hands(food_slots[5])
			user << "<span class='notice'>You take [food_slots[5]] from [src].</span>"
			food_slots[5] = null
	if(href_list["f6"])
		if(food_slots[6])
			user.put_in_hands(food_slots[6])
			user << "<span class='notice'>You take [food_slots[6]] from [src].</span>"
			food_slots[6] = null
	if(href_list["d1"])
		if(drink_slots[1])
			user.put_in_hands(drink_slots[1])
			user << "<span class='notice'>You take [drink_slots[1]] from [src].</span>"
			drink_slots[1] = null
	if(href_list["d2"])
		if(drink_slots[2])
			user.put_in_hands(drink_slots[2])
			user << "<span class='notice'>You take [drink_slots[2]] from [src].</span>"
			drink_slots[2] = null
	if(href_list["d3"])
		if(drink_slots[3])
			user.put_in_hands(drink_slots[3])
			user << "<span class='notice'>You take [drink_slots[3]] from [src].</span>"
			drink_slots[3] = null
	if(href_list["d4"])
		if(drink_slots[4])
			user.put_in_hands(drink_slots[4])
			user << "<span class='notice'>You take [drink_slots[4]] from [src].</span>"
			drink_slots[4] = null
	if(href_list["d5"])
		if(drink_slots[5])
			user.put_in_hands(drink_slots[5])
			user << "<span class='notice'>You take [drink_slots[5]] from [src].</span>"
			drink_slots[5] = null
	if(href_list["d6"])
		if(drink_slots[6])
			user.put_in_hands(drink_slots[6])
			user << "<span class='notice'>You take [drink_slots[6]] from [src].</span>"
			drink_slots[6] = null

	update_icon()		//Not really needed without overlays, but keeping just in case
	updateUsrDialog()

/*
Overlays for cart_unused
/obj/structure/foodcart/update_icon()
	overlays = null
	if(food1)
		overlays += "cart_food1"
	if(food2)
		overlays += "cart_food2"
	if(food3)
		overlays += "cart_food3"
	if(food4)
		overlays += "cart_food4"
	if(food5)
		overlays += "cart_food5"
	if(food6)
		overlays += "cart_food6"
	if(drink1)
		overlays += "cart_drink1"
	if(drink2)
		overlays += "cart_drink2"
	if(drink3)
		overlays += "cart_drink3"
	if(drink4)
		overlays += "cart_drink4"
	if(drink5)
		overlays += "cart_drink5"
	if(drink6)
		overlays += "cart_drink6"
*/