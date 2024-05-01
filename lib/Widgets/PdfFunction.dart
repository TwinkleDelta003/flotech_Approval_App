import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> makePdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        PaddedText('Company Name: ${"invoice.result[0].companyName"}'),
        PaddedText('Date: ${"invoice.result[0].dt"}'),
        PaddedText('PO Number: ${"invoice.result[0].no"}'),
        PaddedText(
            'PO Value: ${double.parse("invoice.result[0].value").toStringAsFixed(0)}'),
        // Add more data from the `invoice` object as needed.
      ],
    ),
  );
  return pdf.save();
}

class PaddedText extends pw.StatelessWidget {
  final String text;
  final pw.TextAlign align;

  PaddedText(this.text, {this.align = pw.TextAlign.left});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
      ),
    );
  }
}
