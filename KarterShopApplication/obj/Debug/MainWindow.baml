   M S B A M L   `   `   `  ����  KarterShopApplication&     KarterShopApplication.MainWindow   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      -   5          �Name$  MainWindow1��5   	    � Title$ 
MainWindow��5      $	��350��6   $	��525��6%    � WindowStyle$
 None=�5       � AllowsTransparency .  � 
ResizeMode$ NoResize=�5       � Triggers 5      :� 5	   
    :� RoutedEvent$ Window.Loaded��6   .[�5
      �� .��5      �� .��5      W�  g� Duration$ 00:00:02D�6&    �� TargetProperty$ Opacity�6:   	 W� From$	 0X�6^   	
 W� To$
 1X�6g   5      5      5      .��5      � -   5         �Name$ MainGrid��5      .+�5   
   �� $��143,196,143.8,108.4q�6   $G��AC:\Users\Rhys\Desktop\KarterShop\Images\rounded-rectangle-xxl.png��6-   $
��Fill=�6x   �� 5   
   $��143,247,143.8,57.4q�6   $G��AC:\Users\Rhys\Desktop\KarterShop\Images\rounded-rectangle-xxl.png��6,   $
��Fill=�6w   �� 5   
   -   5         ��Name$ CloseButton��5      $	����6%   $��FontAwesome)�61   $��30(�6J   $
��Left=�6X   $��	494,5,0,0q�6s   $	��Top=�6�   $��0q�6�   �� 5   
   -   5        $ MinimizeButton��5      $	����6(   $��FontAwesome)�6;   $��30(�6T   $
��Left=�6b   $��	463,5,0,0q�6}   $	��Top=�6�   $��0q�6�   �� 5   
   -   5        $ 	HelpLabel��5      $�� ��6#   $
��Left=�6.   $	��Top=�6I   $��36��6a   $	��458��6m   
���   �$��18(�6�   $��Segoe UI Light)�6�   $��Center=�6�    J� RenderTransformOrigin$ 0.5,0.5&�6�   �� 5   
   $	��116��6   $��143.4,61,143.4,173.4q�6   $	��Top=�6;   $	��238��6S   $@��:C:\Users\Rhys\Desktop\KarterShop\Images\KarterShopLogo.png��6_   $��Center=�6�   �� 5   
   -   5         ��Name$ UsernameTextbox��5      $
��Left=�6+   $��144,205,0,0q�6F   $��Username��6[   $	��Top=�6k   $	��237��6�   $��30��6�   $��Segoe UI Light)�6�   $��16(�6�    �� TextWrapping$
 Wrap=�6�   $	��5,3q�6�   ��6�   Z� ��6�   Z� G� 5   
   -   5         G�Name$ PasswordTextbox��5      $
��Left=�6/   $��143,256,0,0q�6J   $	��Top=�6_   $	��238��6w   $��29��6�    G� Password$ Password��6�   $��Segoe UI Light)�6�   $��16(�6�   $��	5,1.5,5,0q�6�   ��6�   Z� ��6�   Z� �� 5   
   -   5        $ SignUpButton��5      
����  �$!��Not signed up?
Click here!��68   $
��Left=�6f   $��144,300,0,10.4q�6�   $��Center=�6�   $��88��6�   $��Segoe UI Light)�6�   �� 5   
   $��286,298,143.8,6.4q�6   $G��AC:\Users\Rhys\Desktop\KarterShop\Images\rounded-rectangle-xxl.png��6+   $
��Fill=�6v   �� 5   
   -	   5        $ LoginButton��5      $
��Left=�6%   $��288,300,0,0q�6@   $�� ��6U   $	��Top=�6`   $��93��6x   $��40��6�   $��Segoe UI Light)�6�   $��16(�6�   $��5,9,5,5q�6�   ��6�   Z� ��6�   Z� 5      5      