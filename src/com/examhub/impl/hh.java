/*package com.examhub.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.Iterator;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.examhub.pojo.Question;

public class hh {
	public static void main(String[] args) {
		try {
			File file = new File("C:\\Users\\admin\\Desktop\\Book1.xlsx"); // creating a new file instance
			FileInputStream fis = new FileInputStream(file); // obtaining bytes from the file
//creating Workbook instance that refers to .xlsx file  
			XSSFWorkbook wb = new XSSFWorkbook(fis);
			XSSFSheet sheet = wb.getSheetAt(0); // creating a Sheet object to retrieve object
			Iterator<Row> itr = sheet.iterator(); // iterating over excel file
			int i = 0;
			QuestionDaoImpl impl = new QuestionDaoImpl();
			while (itr.hasNext()) {
				Question q = new Question();

				Row row = itr.next();
				Iterator<Cell> cellIterator = row.cellIterator(); // iterating over each column

				cellIterator.hasNext();
				Cell cell = cellIterator.next();
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					q.setQuestion(cell.getNumericCellValue() + "");
				} else {
					q.setQuestion(cell.getStringCellValue().toString());
				}

				cellIterator.hasNext();
				Cell cell1 = cellIterator.next();

				String data = "";

				if (cell1.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					data = cell1.getNumericCellValue() + "";
				} else {
					data = cell1.getStringCellValue();
				}

				q.setOption1(data);

				cellIterator.hasNext();
				Cell cell2 = cellIterator.next();
				if (cell2.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					data = cell2.getNumericCellValue() + "";
				} else {
					data = cell2.getStringCellValue();
				}
				q.setOption2(data);

				cellIterator.hasNext();
				Cell cell3 = cellIterator.next();
				if (cell3.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					data = cell3.getNumericCellValue() + "";
				} else {
					data = cell3.getStringCellValue();
				}
				q.setOption3(data);

				cellIterator.hasNext();
				Cell cell4 = cellIterator.next();
				if (cell4.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					data = cell4.getNumericCellValue() + "";
				} else {
					data = cell4.getStringCellValue();
				}
				q.setOption4(data);

				cellIterator.hasNext();
				Cell cell5 = cellIterator.next();
				if (cell5.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					data = cell5.getNumericCellValue() + "";
				} else {
					data = cell5.getStringCellValue();
				}
				q.setAnswer(data);

				q.setSectionId(8);

				System.out.println(impl.addQuestion(q));
//				
//				while (cellIterator.hasNext()) {
//					
//					Cell cell = cellIterator.next();
//					switch (cell.getCellType()) {
//					case Cell.CELL_TYPE_STRING: // field that represents string cell type
//						System.out.print(cell.getStringCellValue() + "\t\t\t");
//						break;
//					case Cell.CELL_TYPE_NUMERIC: // field that represents number cell type
//						System.out.print(cell.getNumericCellValue() + "\t\t\t");
//						break;
//					default:
//						
//						
//						
//					}
//				}
				System.out.println(++i + "   \n\n\n\n   ");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
*/