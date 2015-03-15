Imports System.Windows.Media.Effects


Class MainWindow

    Private Sub DragWindow(sender As Object, e As MouseButtonEventArgs) Handles HelpLabel.MouseDown
        Try
            DragMove()

        Catch ex As Exception

        End Try

    End Sub

    Private Sub InitializeMyControl()
    End Sub

    Private Sub CloseHover(sender As Object, e As MouseEventArgs) Handles CloseButton.MouseEnter
        CloseButton.Foreground = Brushes.Red
    End Sub

    Private Sub CloseLeave(sender As Object, e As MouseEventArgs) Handles CloseButton.MouseLeave
        CloseButton.Foreground = Brushes.Black
    End Sub

    Private Sub MinimizeHover(sender As Object, e As MouseEventArgs) Handles MinimizeButton.MouseEnter
        MinimizeButton.Foreground = Brushes.Orange
    End Sub

    Private Sub MinimizeLeave(sender As Object, e As MouseEventArgs) Handles MinimizeButton.MouseLeave
        MinimizeButton.Foreground = Brushes.Black
    End Sub

    Private Sub CloseWindow(sender As Object, e As MouseButtonEventArgs) Handles CloseButton.MouseUp
        Close()
    End Sub

    Private Sub MinimizeWindow(sender As Object, e As MouseButtonEventArgs) Handles MinimizeButton.MouseUp
        Me.WindowState = Windows.WindowState.Minimized
    End Sub

    Private Sub LoginContents()
        If String.IsNullOrWhiteSpace(PasswordTextbox.Password) = False Then
            LoginButton.Content = "Login"
        Else
            LoginButton.Content = ""
        End If

    End Sub
End Class
