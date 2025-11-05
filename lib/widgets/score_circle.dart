import 'package:flutter/material.dart';

class ScoreCircle extends StatelessWidget {
  final int score;
  final double circleSize;

  const ScoreCircle({
    super.key,
    required this.score,
    required this.circleSize,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF3F9ED1);
    
    return Container(
      width: circleSize * 1.5, 
      height: circleSize * 1.5,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Center( 
        child: Container(
          width: circleSize * 1.2,
          height: circleSize * 1.2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Center( 
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'your Score',
                    style: TextStyle(
                      fontSize: circleSize * 0.15,
                      color: primaryBlue,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        score.toString(),
                        style: TextStyle(
                          fontSize: circleSize * 0.3,
                          fontWeight: FontWeight.w700,
                          color: primaryBlue,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      Text(
                        'pt',
                        style: TextStyle(
                          fontSize: circleSize * 0.18,
                          fontWeight: FontWeight.w500,
                          color: primaryBlue,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
     )
    );
  }
}