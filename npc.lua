Npc = {}
Npc.__index = Npc

function Npc.New(id)
   self = setmetatable({}, Npc)
   self.id = id
   self.value = value
   self.array = {}
   self.desc = "..."
   return self
end

function Npc.AArray(self, key, message)
   self.array[key] = message
end

return Npc