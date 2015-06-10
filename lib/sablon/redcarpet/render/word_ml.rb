module Sablon
  module Redcarpet
    module Render
      class WordML < ::Redcarpet::Render::Base
        PARAGRAPH_PATTERN = <<-XML.gsub("\n", "")
<w:p>
<w:pPr>
<w:pStyle w:val="%s" />
</w:pPr>
%s
</w:p>
XML

        LIST_PATTERN = <<-XML.gsub("\n", "")
<w:p w:rsidR="00F85B4B" w:rsidRDefault="00F85B4B" w:rsidP="00F85B4B">
<w:pPr><w:pStyle w:val="BodyText"/>
<w:numPr><w:ilvl w:val="0"/>
<w:numId w:val="2"/></w:numPr>
<w:spacing w:before="104" w:line="240" w:lineRule="exact"/>
<w:ind w:right="113"/>
<w:jc w:val="both"/>
<w:rPr>
<w:color w:val="231F20"/>
<w:spacing w:val="4"/>
</w:rPr>
</w:pPr>
<w:r>
<w:rPr>
<w:color w:val="231F20"/>
<w:spacing w:val="4"/>
</w:rPr>
<w:t>
%s
</w:t>
</w:r>
</w:p>
XML


        def linebreak
          "<w:r><w:br/></w:r>"
        end

        def header(title, level)
          heading_style = "Heading#{level}"
          PARAGRAPH_PATTERN % [heading_style, title]
        end

        def paragraph(text)
          PARAGRAPH_PATTERN % ["Paragraph", text]
        end

        def normal_text(text)
          @raw_text = text
          return '' if text.nil? || text == '' || text == "\n"
          "<w:r><w:t xml:space=\"preserve\">#{text}</w:t></w:r>"
        end

        def emphasis(text)
          "<w:r><w:rPr><w:i /></w:rPr><w:t xml:space=\"preserve\">#{@raw_text}</w:t></w:r>"
        end

        def double_emphasis(text)
          "<w:r><w:rPr><w:b /></w:rPr><w:t xml:space=\"preserve\">#{@raw_text}</w:t></w:r>"
        end

        def list(content, list_type)
          # p '-----list-'
          # p list_type
          # p '---content-'
          # p content

          # content
          LIST_PATTERN % [content]
        end

        LIST_STYLE_MAPPING = {
          ordered: "ListNumber",
          unordered: "ListBullet"
        }

        def list_item(content, list_type)
          list_style = LIST_STYLE_MAPPING[list_type]
          PARAGRAPH_PATTERN % [list_style, content]
        end
      end
    end
  end
end
