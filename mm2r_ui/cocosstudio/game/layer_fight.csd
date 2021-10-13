<GameFile>
  <PropertyGroup Name="layer_fight" Type="Node" ID="4169a629-8f11-4ae2-877a-3334ffc93fdb" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Node" Tag="5" ctype="GameNodeObjectData">
        <Size X="0.0000" Y="0.0000" />
        <Children>
          <AbstractNodeData Name="sprite_bg" ActionTag="-607163442" Tag="6" IconVisible="False" LeftMargin="-23.0000" RightMargin="-23.0000" TopMargin="-23.0000" BottomMargin="-23.0000" ctype="SpriteObjectData">
            <Size X="46.0000" Y="46.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="Default" Path="Default/Sprite.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_fight_info" ActionTag="-232284060" Tag="28" IconVisible="True" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="list_fight_info" ActionTag="715105865" Tag="30" IconVisible="False" LeftMargin="-400.0000" RightMargin="-400.0000" TopMargin="40.0000" BottomMargin="-240.0000" TouchEnable="True" ClipAble="True" BackColorAlpha="102" ColorAngle="90.0000" Scale9Enable="True" LeftEage="68" RightEage="68" TopEage="29" BottomEage="29" Scale9OriginX="68" Scale9OriginY="29" Scale9Width="72" Scale9Height="30" ScrollDirectionType="0" DirectionType="Vertical" ctype="ListViewObjectData">
                <Size X="800.0000" Y="200.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-140.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <SingleColor A="255" R="150" G="150" B="255" />
                <FirstColor A="255" R="150" G="150" B="255" />
                <EndColor A="255" R="255" G="255" B="255" />
                <ColorVector ScaleY="1.0000" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_base_operate" ActionTag="939973053" Tag="20" IconVisible="True" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="btn_attack" ActionTag="-1568042293" Tag="7" IconVisible="False" LeftMargin="-620.0000" RightMargin="412.0000" TopMargin="272.0000" BottomMargin="-360.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="178" Scale9Height="66" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="208.0000" Y="88.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="426397354" Tag="9" IconVisible="False" LeftMargin="46.5000" RightMargin="46.5000" TopMargin="16.0000" BottomMargin="16.0000" FontSize="50" LabelText="攻 击" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="115.0000" Y="56.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="104.0000" Y="44.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5529" Y="0.6364" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-516.0000" Y="-316.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <PressedFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <NormalFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_car" ActionTag="309026529" Tag="10" IconVisible="False" LeftMargin="-362.0000" RightMargin="154.0000" TopMargin="272.0000" BottomMargin="-360.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="178" Scale9Height="66" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="208.0000" Y="88.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="-1822567311" Tag="11" IconVisible="False" LeftMargin="46.0000" RightMargin="46.0000" TopMargin="16.0000" BottomMargin="16.0000" FontSize="50" LabelText="乘 降" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="116.0000" Y="56.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="104.0000" Y="44.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5577" Y="0.6364" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-258.0000" Y="-316.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <PressedFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <NormalFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_trick" ActionTag="-707626145" Tag="12" IconVisible="False" LeftMargin="-104.0000" RightMargin="-104.0000" TopMargin="272.0000" BottomMargin="-360.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="178" Scale9Height="66" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="208.0000" Y="88.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="-214554671" Tag="13" IconVisible="False" LeftMargin="46.0000" RightMargin="46.0000" TopMargin="16.0000" BottomMargin="16.0000" FontSize="50" LabelText="特 技" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="116.0000" Y="56.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="104.0000" Y="44.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5577" Y="0.6364" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-316.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <PressedFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <NormalFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_prop" ActionTag="-2044815680" Tag="14" IconVisible="False" LeftMargin="154.0000" RightMargin="-362.0000" TopMargin="272.0000" BottomMargin="-360.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="178" Scale9Height="66" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="208.0000" Y="88.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="2145116358" Tag="15" IconVisible="False" LeftMargin="46.5000" RightMargin="46.5000" TopMargin="16.0000" BottomMargin="16.0000" FontSize="50" LabelText="道 具" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="115.0000" Y="56.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="104.0000" Y="44.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5529" Y="0.6364" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="258.0000" Y="-316.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <PressedFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <NormalFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_other" ActionTag="654590318" Tag="16" IconVisible="False" LeftMargin="412.0000" RightMargin="-620.0000" TopMargin="272.0000" BottomMargin="-360.0000" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="178" Scale9Height="66" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="208.0000" Y="88.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="-517441019" Tag="17" IconVisible="False" LeftMargin="46.0000" RightMargin="46.0000" TopMargin="16.0000" BottomMargin="16.0000" FontSize="50" LabelText="其 他" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="116.0000" Y="56.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="104.0000" Y="44.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5577" Y="0.6364" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="516.0000" Y="-316.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <PressedFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <NormalFileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="node_other" ActionTag="-645128851" Tag="14" IconVisible="True" LeftMargin="516.0000" RightMargin="-516.0000" TopMargin="64.0000" BottomMargin="-64.0000" ctype="SingleNodeObjectData">
            <Size X="0.0000" Y="0.0000" />
            <Children>
              <AbstractNodeData Name="image_bg" ActionTag="181370105" Tag="15" IconVisible="False" LeftMargin="-104.0000" RightMargin="-104.0000" TopMargin="-194.0000" BottomMargin="-194.0000" Scale9Enable="True" LeftEage="68" RightEage="68" TopEage="29" BottomEage="29" Scale9OriginX="68" Scale9OriginY="29" Scale9Width="72" Scale9Height="30" ctype="ImageViewObjectData">
                <Size X="208.0000" Y="388.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FileData Type="Normal" Path="game/res/ui/btn_normal.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_run_away" ActionTag="1315789126" Tag="16" IconVisible="False" LeftMargin="-60.0000" RightMargin="-60.0000" TopMargin="-155.0000" BottomMargin="105.0000" TouchEnable="True" FontSize="34" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="120.0000" Y="50.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="941384310" Tag="21" IconVisible="False" LeftMargin="24.5000" RightMargin="24.5000" TopMargin="6.0000" BottomMargin="6.0000" FontSize="34" LabelText="逃跑" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="71.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="60.0000" Y="25.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="0" G="0" B="0" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5917" Y="0.7600" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="130.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_defence" ActionTag="20392254" Tag="17" IconVisible="False" LeftMargin="-60.0000" RightMargin="-60.0000" TopMargin="-85.0000" BottomMargin="35.0000" TouchEnable="True" FontSize="34" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="120.0000" Y="50.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="-1751028433" Tag="25" IconVisible="False" LeftMargin="25.0000" RightMargin="25.0000" TopMargin="6.0000" BottomMargin="6.0000" FontSize="34" LabelText="防御" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="70.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="60.0000" Y="25.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="0" G="0" B="0" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5833" Y="0.7600" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="60.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_safe" ActionTag="-204321035" Tag="18" IconVisible="False" LeftMargin="-60.0000" RightMargin="-60.0000" TopMargin="-15.0000" BottomMargin="-35.0000" TouchEnable="True" FontSize="34" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="120.0000" Y="50.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="1292501929" Tag="26" IconVisible="False" LeftMargin="25.5000" RightMargin="25.5000" TopMargin="6.0000" BottomMargin="6.0000" FontSize="34" LabelText="保护" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="69.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="60.0000" Y="25.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="0" G="0" B="0" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5750" Y="0.7600" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-10.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_system" ActionTag="-1317237601" Tag="19" IconVisible="False" LeftMargin="-60.0000" RightMargin="-60.0000" TopMargin="55.0000" BottomMargin="-105.0000" TouchEnable="True" FontSize="34" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="120.0000" Y="50.0000" />
                <Children>
                  <AbstractNodeData Name="text_title" ActionTag="-1871699346" Tag="27" IconVisible="False" LeftMargin="24.5000" RightMargin="24.5000" TopMargin="6.0000" BottomMargin="6.0000" FontSize="34" LabelText="系统" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="71.0000" Y="38.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="60.0000" Y="25.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="0" G="0" B="0" />
                    <PrePosition X="0.5000" Y="0.5000" />
                    <PreSize X="0.5917" Y="0.7600" />
                    <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position Y="-80.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition />
                <PreSize X="0.0000" Y="0.0000" />
                <FontResource Type="Normal" Path="fonts/FZZY.TTF" Plist="" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
                <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint />
            <Position X="516.0000" Y="-64.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0000" Y="0.0000" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>