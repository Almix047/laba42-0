json.projects @projects do |project|
  json.id project.id
  json.title project.title
  json.created_at project.created_at
  json.deadline project.deadline
  json.skills project.skills.split(',')
  json.info project.info
  json.type project.project_type

  json.extended_info do
    json.owner project.user.name
    json.payment project.cost_type
    json.cost project.cost
    json.status project.status
    json.employee_id project.employee
  end
end
