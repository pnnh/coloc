# coding: utf-8

module ArticlesHelper
    def update_time(time)
        now = Time.new
        sub = now - time
        if sub <= 60
            '刚刚'
        elsif sub <= 300
            '5分钟内'
        elsif sub <= 600
            '10分钟内'
        elsif sub <= 1800
            '30分钟内'
        elsif sub <= 3600
            '1小时内'
        else
            day = Date.new(now.year, now.month, now.day)
            if time > day
                time.strftime('今天 %H:%M')
            elsif time > day - 1
                time.strftime('昨天 %H:%M')
            elsif time > day - 2
                time.strftime('前天 %H:%M')
            else
                time.strftime('%m月%d日 %H:%M')
            end
        end
    end
end
