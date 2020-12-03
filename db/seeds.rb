participants = [ { name: "Буйчик", nickname: "bui" },
                 { name: "Никита", nickname: "nik" },
                 { name: "Пест", nickname: "pes" },
                 { name: "Дима", nickname: "dim" } ]

participants.each do |part|
  Participant.find_or_create_by( name: part[:name],
                      nickname: part[:nickname])
end

checkpoints = [] + (1..7).map { |n| "Зачет #{n}" } + ["Теория ГАИ", "Практика ГАИ"]

checkpoints.each_with_index do |val, ind |
  Checkpoint.find_or_create_by(name: val, order: ind + 1)
end
