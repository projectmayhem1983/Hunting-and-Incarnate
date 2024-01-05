function init()
  self.gravityModifier = effect.configParameter("gravityModifier")
  self.movementParams = mcontroller.baseParameters()
  
  setGravityMultiplier()

  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", basePercentage = -1}})

  script.setUpdateDelta(5)

  self.healingRate = 1.0 / effect.configParameter("healTime", 60)
end

function setGravityMultiplier()
  local oldGravityMultiplier = self.movementParams.gravityMultiplier or 1

  self.newGravityMultiplier = self.gravityModifier * oldGravityMultiplier
end

function update(dt)
  mcontroller.controlParameters({
     gravityMultiplier = self.newGravityMultiplier
  })
  status.modifyResourcePercentage("health", self.healingRate * dt)
end

function uninit()

end
