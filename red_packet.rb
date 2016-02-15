
class RandomGaussian
  def initialize(mean, stddev, rand_helper = lambda { Kernel.rand })
    @rand_helper = rand_helper
    @mean = mean
    @stddev = stddev
    @valid = false
    @next = 0
  end

  def rand
    if @valid then
      @valid = false
      return @next
    else
      @valid = true
      x, y = self.class.gaussian(@mean, @stddev, @rand_helper)
      @next = y
      return x
    end
  end

  private
  def self.gaussian(mean, stddev, rand)
    theta = 2 * Math::PI * rand.call
    rho = Math.sqrt(-2 * Math.log(1 - rand.call))
    scale = stddev * rho
    x = mean + scale * Math.cos(theta)
    y = mean + scale * Math.sin(theta)
    return x, y
  end
end



def generateMoneyVector(mon, pics)
	if mon < pics * 0.01
		puts "金额不足"  
	else
		return [mon] if pics == 1
		valueVec = []
		moneyLeft = (mon - pics * 0.01)
		0.upto(pics-2) do |i|
			mu = moneyLeft / (pics - i)
		    sigma = mu / 2
		    rg = RandomGaussian.new(mu,sigma)
		    noiseValue = rg.rand.round(2)
		    noiseValue = 0 if noiseValue < 0
		    noiseValue = moneyLeft if noiseValue > moneyLeft
		    valueVec << (noiseValue + 0.01).round(2)
		    moneyLeft -= noiseValue
		end
		valueVec << (mon - valueVec.reduce(&:+)).round(2)
		return valueVec
    end
end






