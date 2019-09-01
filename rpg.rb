MINIMUM_HP = 0
PLAYER_1_HP = 1000
PLAYER_2_HP = 1200
PLAYER_3_HP = 900

ENEMY_HP = 5000



def player_hp_calc(damage,player)
    eval("$hp_#{player} -= damage")

    if eval("$hp_#{player}") > MINIMUM_HP
        puts "#{player}の残りHPは#{eval("$hp_#{player}")}になった！"
    else
        puts "#{player}は倒れた！"
    end
end
    
    
def enemy_hp_calc(damage,enemy)
    eval("$hp_#{enemy} -= damage")

    if eval("$hp_#{enemy}") > MINIMUM_HP
        puts "#{enemy}の残りHPは#{eval("$hp_#{enemy}")}になった！"
    end
end




class Player
    def initialize(name,hp)
        @name = name
        eval("$hp_#{@name} = hp")
    end
    
    def attack(enemy)
        damage = rand(1..6)*50
        puts "#{@name}は、#{enemy}を攻撃した！"
        puts "#{enemy}に#{damage}のダメージ！"
        
        enemy_hp_calc(damage,enemy)
    end
    
    def check_hp
        eval("$hp_#{@name}")
    end
    
    def check_name
        @name
    end
        
end


class Warrior < Player
    
    def behead(enemy)
        damage = rand(1..6)*80
        puts "#{@name}は、#{enemy}を激しく切りつけた！！"
        puts "#{enemy}に#{damage}のダメージ！"
        
        enemy_hp_calc(damage,enemy)
    end
    
    def jump(enemy)
        damage = rand(1..6)*70
        puts "#{@name}は#{enemy}にジャンプ斬りをはなった！！"
        puts "#{enemy}に#{damage}のダメージ！"
        
        enemy_hp_calc(damage,enemy)
    end
end


class Wizard < Player
    
    def fire_ball(enemy)
        damage = rand(1..6)*60
        puts "#{@name}は、#{enemy}に火の玉の呪文を唱えた！！"
        puts "#{enemy}に#{damage}のダメージ！"
        
        enemy_hp_calc(damage,enemy)
    end
    
    def block_ice(enemy)
        damage = rand(1..6)*70
        puts "#{@name}は、#{enemy}に氷塊の呪文を唱えた！！"
        puts "#{enemy}に#{damage}のダメージ！"
        
        enemy_hp_calc(damage,enemy)
    end
    
    def explosion(enemy)
        damage = rand(3..5)*200
        puts "#{@name}は#{enemy}に大爆発の呪文を唱えた！！"
        puts "#{enemy}に#{damage}のダメージ！"
        puts "#{@name}は1000000のダメージを受けた！！"
        
        enemy_hp_calc(damage,enemy)
        player_hp_calc(1000000,@name)
        
    end
end


class Enemy < Player

    def attack(player)
        damage = rand(1..5)*50
        puts "#{@name}は#{player}を攻撃した！"
        puts "#{player}に#{damage}のダメージ！"
        
        player_hp_calc(damage,player)
        
    end
    
    def fire_spell(player)
        damage = rand(3..5)*60
        puts "#{@name}は#{player}に炎の呪文を唱えた！！"
        puts "#{player}に#{damage}のダメージ！"
        
        player_hp_calc(damage,player)
    end
    
    def ice_spell(player)
        damage = rand(3..5)*70
        puts "#{@name}は#{player}に氷の呪文を唱えた！！"
        puts "#{player}に#{damage}のダメージ！"
        
        player_hp_calc(damage,player)
    end
    
    def dark_spell(player)
        damage = rand(3..5)*200
        puts "グオオおおおおおおおお！！！！！"
        puts "#{@name}は#{player}に闇の最強呪文を唱えた！！！！"
        puts "#{player}に#{damage}のダメージ！"
        
        player_hp_calc(damage,player)
    end
        
    
end



def use_item(player,item,recovery_amount)
    eval("$hp_#{player} += recovery_amount")
    puts "#{player}は#{item}を使った！"
    puts "#{player}のHPが#{recovery_amount}回復した！！"
end




#------------------------
#セットアップ
#------------------------

player_1 = Player.new("Taro",PLAYER_1_HP)
player_2 = Warrior.new("Kojiro",PLAYER_2_HP)
player_3 = Wizard.new("Michael",PLAYER_3_HP)

enemy = Enemy.new("魔王",ENEMY_HP)

party = [player_1,player_2,player_3]


#------------------------
#バトル開始
#------------------------

$game_flg = true

while $game_flg

    #------------------------
    #プレイヤーの攻撃
    #------------------------
    party.each do |player|
        
        if player.class == Player
            player.attack("魔王")
            
        elsif player.class == Warrior
            attack_select = rand(1..10)
            if  attack_select <= 5
                player.attack("魔王")
            elsif attack_select > 6 && attack_select <= 8
                player.behead("魔王")
            else
                player.jump("魔王")
            end
        else
            attack_select = rand(1..10)
            if  attack_select <= 5
                player.attack("魔王")
            elsif attack_select >= 6 && attack_select <= 7
                player.fire_ball("魔王")
            elsif attack_select >= 8 && attack_select <= 9
                player.block_ice("魔王")
            else
                player.explosion("魔王")
            end
        end
    end
    
    if enemy.check_hp < 0
        puts "#{enemy.check_name}を倒した！！バトルに勝利した！！"
        break 
    end
    
    #------------------------
    #魔王の攻撃
    #------------------------
    enemy_attack_select = rand(1..10)
    if enemy_attack_select <=3
        enemy.attack(party.sample.check_name)
    elsif enemy_attack_select >= 4 && enemy_attack_select <=6
        enemy.fire_spell(party.sample.check_name)
    elsif enemy_attack_select >= 7 && enemy_attack_select <=9
        enemy.ice_spell(party.sample.check_name)
    else
        enemy.dark_spell(party.sample.check_name)
    end
    
    
    party.delete_if {|player| player.check_hp < 0}
    if party.length == 0
        puts "全滅した・・・"
        break
    end
    
    
    
    #------------------------
    #アイテム
    #------------------------
    
    item_select = rand(1..10)
    if item_select <=3
        use_item(party.sample.check_name,"薬草",100)
    elsif item_select >= 4 && item_select <= 5
        use_item(party.sample.check_name,"ポーション",200)
    end
end



