def update_vectors
  if self.exchange.day % 90 == 0
    self.annual_vec = Rubystats::NormalDistribution.new(0, 1).rng
  end

  if self.exchange.day % 7 == 0
    self.intermediate_vec = Rubystats::NormalDistribution.new(self.annual_vec/3, VOLITILITY).rng
  end

  self.daily_vec = Rubystats::NormalDistribution.new(self.intermediate_vec/3, VOLITILITY).rng
end
