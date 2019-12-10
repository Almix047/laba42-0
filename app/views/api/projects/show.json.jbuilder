json.id @project.id
json.title @project.title
json.owner @project.user.name
json.info @project.info
json.skills @project.skills
json.created @project.created_at
json.deadline @project.deadline
json.type @project.project_type
json.payment @project.cost_type
json.cost @project.cost
json.status @project.status
json.employee_id @project.employee


# json.current do
#   json.temp @location.recordings.last.temp
#   json.status @location.recordings.last.status
# end
