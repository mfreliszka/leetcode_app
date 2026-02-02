import flet as ft


def main(page: ft.Page):
    counter = ft.Text("0", size=50, data=0)

    def increment_click(e):
        counter.data += 2
        counter.value = str(counter.data)

    page.floating_action_button = ft.FloatingActionButton(
        icon=ft.Icons.ADD, on_click=increment_click
    )
    page.add(
        ft.SafeArea(
            expand=True,
            content=ft.Container(
                content=counter,
                alignment=ft.Alignment.CENTER,
            ),
        )
    )

    page.bottom_appbar = ft.BottomAppBar(
        bgcolor=ft.Colors.SURFACE_CONTAINER_LOW,
        content=ft.Row(
            alignment=ft.MainAxisAlignment.SPACE_AROUND,
            controls=[
                ft.IconButton(
                    ft.Icons.MENU,
                    on_click=lambda e: print("Menu clicked"),
                ),
                ft.IconButton(
                    ft.Icons.SEARCH,
                    on_click=lambda e: print("Search clicked"),
                ),
                ft.IconButton(
                    ft.Icons.SETTINGS,
                    on_click=lambda e: print("Settings clicked"),
                ),
            ],
        ),
    )

ft.run(main)
