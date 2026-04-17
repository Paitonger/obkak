-- 17.04
net.Receive('sendTableToAdmin', function()
    local info = net.ReadTable()
    for i=1,table.Count(info) do
        print('--------------------')
        print('Донат: '..info[i]['Item'])
        print('ID: '..info[i]['ID'])
        print('--------------------')
    end
end)

net.Receive('sendResultDisable', function()
    local result = net.ReadBool()
    if result then
    print('Покупка успешно отключена')
    else
    print('Покупка уже была отключена')
    end
end)