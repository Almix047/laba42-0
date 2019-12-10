json.id @project.id
json.title @project.title
json.owner @project.user.name
json.info @project.info
json.skills @project.skills
json.created_at @project.created_at
json.deadline @project.deadline
json.type @project.project_type
json.payment @project.cost_type
json.cost @project.cost
json.status @project.status
json.employee_id @project.employee

json.applies @applies do |apply|
  json.apply_id apply.id
  json.apply_owner apply.user.name
  json.apply_created_at apply.created_at
  json.apply_status apply.apply_status
end

json.comments @comments do |comment|
  json.comment_id comment.id
  json.content comment.content
  json.comment_created_at comment.created_at
  json.comment_owner comment.user.name
end
