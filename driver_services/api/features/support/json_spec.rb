module JSONSpecInterface
  def last_json
    page.source
  end
end

World(JSONSpecInterface)