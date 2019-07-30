class Test
  def aa
    raise StandardError, 'test message'
  rescue StandardError => e
    pp e.inspect
  end

  def bb
    raise StandardError, 'test message'
  rescue StandardError => e
    pp e.to_json
  end
end