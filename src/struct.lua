
address = function(default)
  if default then
    system.isContract(default) -- throws error if not valid address
  end
  return {"address", default or "1111111111111111111111111111111111111111111111111111"}
end

bignumber = function(default)
  return {"bignumber", bignum.number(default or 0)}
end

number = function(default)
  return {"number", default and tonumber(default) or 0}
end

boolean = function(default)
  return {"boolean", (default==true) or false}
end

string = function(default)
  return {"string", default and tostring(default) or ""}
end

is_struct_type = function(value)
   if type(value) == "table" then
      if #value == 2 then
        if value[i] == "address" or value[i] == "bignumber" or value[i] == "number" or value[i] == "boolean" or value[i] == "string" then
          return true
        end      
      end    
   end
end

array = function(default)
  default = default or {}
  local final = {}
  for i = 1, #default do
     final = table.insert(final, default[i])
  end
  return {"array", final}
end

function struct(struct_type)

   if not is_struct_type(struct_type()) then
     error "bad arg #1 for struct, expected struct_type"
   end
  
  return (function(structure)
      local final = {}
      for k,v in pairs(structure) do      
        if not is_struct_type(v) then
           error "bad arg #1 for struct "..k..", expected struct_type"
        end
        final[k] = v
      end
      return final
  end)

end
