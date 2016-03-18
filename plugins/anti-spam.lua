------------------------------------------
--                   @h3iran                    --
--------------------------------------------------
local function pre_process(msg)
   
        floodMax = 5 --you can change it!
        floodTime = 3 --you can change it!
   
    if not permissions(msg.from.id, msg.to.id, "pre_process") then
        --Checking flood
                   print('anti-flood enabled')
            -- Check flood
            if msg.from.type == 'user' then
                if not permissions(msg.from.id, msg.to.id, "no_flood_ban") then
                    -- Increase the number of messages from the user on the chat
                    local hash = 'flood:'..msg.from.id..':msg-num'
                    local msgs = tonumber(redis:get(hash) or 0)
                    if msgs > floodMax then
                        local receiver = get_receiver(msg)
                        local user = msg.from.id
                       
			if msg.to.type == 'user' then
                            send_msg(receiver, "Blocked :D", ok_cb, true)
                         block_user(receiver,ok_cb,false)
                        end
                    end
                    redis:setex(hash, floodTime, msgs+1)
                end
            end
        end
end
return {
    pre_process = pre_process,
}
