json.projects @projects do |project|
  json.id project.id
  json.title project.title
  json.created project.created_at
  json.deadline project.deadline
  json.skills project.skills
  json.info project.info

  json.extended_info do
    json.owner project.user.name
    json.type project.project_type
    json.payment project.cost_type
    json.cost project.cost
    json.status project.status
    json.employee_id project.employee
  end
end
