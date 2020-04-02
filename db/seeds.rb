Client.create!(client_id: "277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe", client_secret: "d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352")

Widget.create!(name: 'A Hidden Widget', description: "Widget 1")
Widget.create!(name: 'A New Widget', description: "Widget 2")

User.create!(email: 'ronakabhattrz@gmail.com', first_name: "Ronak", last_name: "Bhatt", image_url: "https://static.thenounproject.com/png/961-200.png", password: '12345678', password_confirmation: '12345678')

UserWidget.create!(user_id: User.last.id, widget_id: Widget.first.id)
UserWidget.create!(user_id: User.last.id, widget_id: Widget.last.id)