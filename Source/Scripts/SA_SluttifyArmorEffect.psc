Scriptname SA_SluttifyArmorEffect extends ActiveMagicEffect
{Converts armor to sluttified version}

Event OnEffectStart(Actor Target, Actor Caster)
    Form pureClothes = Target.GetWornForm(4)
    Form slutClothes = JFormDB.getForm(pureClothes, ".SluttifyArmor.slutForm")

    ; Name will be empty on invalid forms
    If slutClothes.GetName() == ""
        Debug.MessageBox("Unable to find slut variant of " + pureClothes.GetName() + ".")
        return
    EndIf

    Int slotMask = 4
    If pureClothes.GetName() != ""
        Float health = WornObject.GetItemHealthPercent(Target, 0, slotMask)
        Enchantment sourceEnchant = WornObject.GetEnchantment(Target, 0, slotMask)
        Float sourceMaxCharge = WornObject.GetItemMaxCharge(Target, 0, slotMask)

        Debug.trace("[SA] Found slut armor: " + slutClothes.GetName())
        Target.RemoveItem(pureClothes)
        Debug.trace("[SA] Removed item: " + pureClothes.GetName())
        Target.EquipItem(slutClothes)
        Debug.trace("[SA] Equipped armor: " + slutClothes.GetName())

        ; Crashes randomly if you don't wait a bit to temper the armor. Might be conflicting with mods that
        ; modify incoming armor (MWA, specifically)
        Utility.Wait(0.5)
        If health != 1.0
            WornObject.SetItemHealthPercent(Target, 0, slotMask, health)
            Debug.trace("[SA] Tempered armor: " + slutClothes.GetName() + " to " + (health as string))
        EndIf
        If sourceEnchant != None
            WornObject.SetEnchantment(Target, 0, slotMask, sourceEnchant, sourceMaxCharge)
            Debug.trace("[SA] Enchanted armor: " + slutClothes.GetName())
        EndIf
    Else
        Debug.MessageBox("Failed to sluttify " + pureClothes.GetName() + ".")
        return
    EndIf

    Debug.MessageBox("Sluttified " + pureClothes.GetName() + ". All that excess material was too constricting anyway.")
EndEvent
