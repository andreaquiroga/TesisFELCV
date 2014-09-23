# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
grades = Grade.create([{name: "SUBTENIENTE"}, {name: "TENIENTE"}, {name: "CAPITAN"}, {name: "MAYOR"}, {name: "TENIENTE CORONEL"}, {name: "CORONEL"}])
roles = Role.create([{name: "admin"}, {name: "investigador"}, {name: "directora"}, {name: "secretaria"}])
civil = CivilStatus.create([{name: "Soltero"}, {name: "Casado"}, {name: "Divorciado"}, {name: "Viudo"}, {name: "Concubinado"}])
gender = Gender.create([{text: "Femenino"}, {text: "Masculino"}])
person_role = PersonRole.create([{text: "Victima"}, {text: "Agresor"}, {text: "Denunciante"}, {text: "Testigo"}])
user_status = UserStatus.create([{text: "Activo"}, {text: "Inactivo"}, {text: "Vacaciones"}, {text: "Baja medica"}])
admin = User.new(email: "admin@gmail.com", password: "administrador", password_confirmation:"administrador", role: roles.first, ci: 00000, name: "admin", paternal_last_name: "admin", maternal_last_name: "admin", grade: "CORONEL", phone: "4000000", mobile: "7000000")
admin.save!(:validate => false)